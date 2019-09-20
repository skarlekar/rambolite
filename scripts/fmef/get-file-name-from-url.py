import sys
def main(url):
    file=url.split("/")[-1]
    return file

if __name__ == '__main__':
    print(main(sys.argv[1]))
