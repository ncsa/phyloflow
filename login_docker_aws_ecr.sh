
aws ecr-public get-login-password --profile phyloflow --region us-east-1 | docker login --username AWS --password-stdin public.ecr.aws/k1t6h9x8
