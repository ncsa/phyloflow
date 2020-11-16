import sys

def main(args):
    success = False

    print("hello from inside main.py")

    print("python got the args: " + str(args))

    success = True
    return success

if __name__ == "__main__":
    succeeded = main(sys.argv[1:])

    if succeeded:
        exit_code = 0
    else:
        exit_code = 1

    sys.exit(exit_code)
