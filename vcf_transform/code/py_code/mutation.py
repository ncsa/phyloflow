from dataclasses import dataclass, asdict
from typing import List
import vcf
import json
import csv
from pathlib import Path

@dataclass
class Mutation(object):
    """
    equivalent to a row in a vcf file
    """
    sample_id:str
    mutation_id:str
    ref_counts:int
    alt_counts:int #'var_counts' in some contexts
    major_cn:int = 2 #FIXME: compute real value
    minor_cn:int = 2 #FIXME: compute real value
    normal_cn:int = 2 #FIXME: compute real value

    @staticmethod
    def from_mutect_vcf_record(sample_id:str, vcf_record:vcf.model._Record):
        """
        initialize a Mutation from a _Record (row) object returned 
        by a vcf.Reader. The vcf file must contain the 'mutect' output 
        format output. 
        """

        mutation_id = Mutation._construct_mutation_id(vcf_record)

        #A25 -> AD 
        #TODO: should these be parameters, or are they hardcoded for 'mutect'?
        tumor_call = vcf_record.genotype('A25')
        call_data = tumor_call.data
        counts = call_data.AD
        ref_counts =  counts[0]
        alt_counts = counts[1] 

        mut = Mutation(
            sample_id=sample_id, 
            mutation_id=mutation_id, 
            ref_counts=ref_counts, 
            alt_counts=alt_counts)

        return mut

    @staticmethod
    def _construct_mutation_id(vcf_record:vcf.model._Record) -> str:
        """
        The id of the mutation of the record has format
            chrom:pos:ref
        """
        chrom = str(vcf_record.CHROM)
        pos = str(vcf_record.POS)
        ref = str(vcf_record.REF)
        #mid = (chrom + ":" + pos + ":" + ref).decode('utf-8')
        mid = (chrom + ":" + pos)
        return mid


def write_mutations_json(out_fn:str, mutations:List[Mutation]) -> None:
    print("writing mutations as json to : " + str(out_fn))
    jd = [asdict(x) for x in mutations]
    with open(out_fn, 'w') as outfile:
        json.dump(jd, outfile, indent=4)
    return

def write_pyclone_vi_input(out_fn:str, mutations:List[Mutation]) -> None:
    """
    write the mutations to a single tsv file, including all samples, as described
    by the pyclone-vi docs: https://github.com/Roth-Lab/pyclone-vi
    """
    print("writing mutations as pyclone-vi input format: " + str(out_fn))

    fieldnames = ['sample_id', 'mutation_id', 'ref_counts', 'alt_counts',
        'major_cn', 'minor_cn', 'normal_cn']

    with open(out_fn, 'w', newline='') as csvfile:

        writer = csv.DictWriter(csvfile,
            fieldnames=fieldnames,
            delimiter='\t',
            quotechar='"',
            quoting=csv.QUOTE_MINIMAL,
            extrasaction='ignore')

        writer.writeheader()
        for m in mutations:
            writer.writerow(asdict(m))
    return

def write_pyclone_inputs(out_dirname:str, mutations:List[Mutation]) -> None:
    """
    write the mutations to a set of tsv files, one per sample, as described
    by the pyclone docs: https://github.com/Roth-Lab/pyclone
    """
    print("writing mutations as pyclone input format to: " + str(out_dirname))

    fieldnames = ['mutation_id', 'ref_counts', 'var_counts',
        'major_cn', 'minor_cn', 'normal_cn']

    #index the mutations by sample_id
    mutations_map = dict()
    for m in mutations:
        sample_id = m.sample_id
        if not sample_id in mutations_map:
            mutations_map[sample_id] = list()
        mutations_map[sample_id].append(m)

    for sample_id in mutations_map:
        out_fn = Path(out_dirname, (sample_id + '.tsv'))

        with open(out_fn, 'w', newline='') as csvfile:

            writer = csv.DictWriter(csvfile,
                fieldnames=fieldnames,
                delimiter='\t',
                quotechar='"',
                quoting=csv.QUOTE_MINIMAL,
                extrasaction='ignore')

            writer.writeheader()
            for m in mutations_map[sample_id]:
                md  = asdict(m)
                #pyclone calls them 'var' not 'alt'
                md['var_counts'] = md['alt_counts']
                writer.writerow(md)
    return

"""
PYCLONE-VI inputs



mutation_id - Unique identifier for the mutation. This is free form but should match across all samples.

Note: PyClone-VI will remove any mutations without entries for all detected samples. If you have mutations with no data in some samples set their ref/alt counts to 0 for the corresponding sample.

sample_id - Unique identifier for the sample.

ref_counts - Number of reads matching the reference allele.

alt_counts - Number of reads matching the alternate allele.

major_cn - Major copy number of segment overlapping mutation.

minor_cn - Minor copy number of segment overlapping mutation.

normal_cn - Total copy number of segment in healthy tissue. For autosome this will be two and male sex chromosomes one.

You can include the following optional columns.

tumour_content - The tumour content (cellularity) of the sample. Default value is 1.0 if column is not present.

Note: In principle this could be different for each mutations/sample. However it most cases it should be the same for all mutations in a sample.

error_rate - Sequencing error rate. Default value is 0.001 if column is not present.
"""


