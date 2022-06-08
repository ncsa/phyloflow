import sys
import argparse
import csv
import json


def main(args):
    success = False

    convert_tsv(args.tsv, args.output)
    convert_tree(args.json, args.output)

    success = True
    return success


def convert_tsv(tsv_file, output_prefix):
    with open(tsv_file, 'r') as ifile, open(f"{output_prefix}.snv.csv", 'w') as ofile:
        print(f"{output_prefix}.snv.csv")
        ofile.write("Sample,chr,pos,ref,alt\n")
        reader = csv.DictReader(ifile, delimiter='\t')
        for row in reader:
            sample = row["cluster_id"]
            chrom, pos, ref_alt = row["mutation_id"].split(':')
            ref, alt = ref_alt.split('>')
            alt = alt[1:-1]
            ofile.write(f"{sample},{chrom},{pos},{ref},{alt}\n")


def convert_tree(json_file, output_prefix):
    with open(json_file, 'r') as ifile, open(f"{output_prefix}.tree.csv", 'w') as ofile:
        print(f"{output_prefix}.tree.csv")
        tree = json.load(ifile)
        nodes = tree["nodes"]
        id2label = {}
        for node in nodes:
            id2label[node["id"]] = node["label"][1:-1].split(',')[0]
        edges = tree["sol_0"] # FIXME
        edge_list = []
        for edge in edges:
            s = id2label[edge["source"]]
            t = id2label[edge["target"]]
            if s != '*' and t != '*':
                edge_list.append([s, t])
        ofile.write("V1,V2\n")
        ofile.write('\n'.join(f"{edge[0]},{edge[1]}" for edge in edge_list))


if __name__ == "__main__":
    parser = argparse.ArgumentParser("Transform SPRUCE output to Physigs input")
    parser.add_argument("-t", "--tsv", type=str,
                        help="pyclone-vi's output assignment TSV file, contaning variants")
    parser.add_argument("-j", "--json", type=str,
                        help="SPRUCE's output tree json file")
    parser.add_argument("-o", "--output", type=str,
                        help="output file prefix for Physigs")
    args = parser.parse_args(None if sys.argv[1:] else ['-h'])

    succeeded = main(args)

    if succeeded:
        exit_code = 0
    else:
        exit_code = 1

    sys.exit(exit_code)
