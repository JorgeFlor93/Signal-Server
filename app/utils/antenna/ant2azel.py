#!/usr/bin/env python2
import sys 
import getopt
import os.path 
from os.path import splitext


def db_to_norm(db):
    return 10**(db/20.)


def main(argv):
    antfile = ''
    outfile = ''
    direction = 0
    tilt = 0
    debug = 0
    program = os.path.basename(__file__)

    try:
        opts, args = getopt.getopt(argv,"dha:i:o:t:",["debug","help","azimuth=","infile=","outfile=","tilt="])
    except getopt.GetoptError:
        print program + '  --debug --help -a <azimuth> -t <mechanicaldowntilt> -i <inputfile> -o <outputfile>'
        sys.exit(2)
    for opt, arg in opts:
        if opt in ("-d", "--debug"):
            debug = 1
        elif opt in ("-h", "--help"):
            print  program + ' --debug --help -a <azimuth> -t <mechanicaldowntilt> -i <inputfile> -o <outputfile>'
            sys.exit(2)
        elif opt in ("-i", "--infile"):
            antfile = arg
        elif opt in ("-o", "--outfile"):
            outfile = arg
        elif opt in ("-a", "--azimuth"):
            direction = arg
        elif opt in ("-t", "--tilt"):
            tilt = arg
    if antfile == '':
        print  program + ' --debug --help -a <azimuth> -t <mechanicaldowntilt> -i <inputfile> -o <outputfile>'
        sys.exit(2)
    if outfile == '' :
        outfile = splitext(antfile)[0]
    if debug :
        print "outfile " + str(outfile)
        print "downtilt " + str(tilt)
    with open(antfile, 'r') as ant:
        with open(outfile + '.az', 'w') as az:
            # azimuth offset as provided by command arg or 0
            az.write("%d\n" % float(direction))
            # Read the first 360 lines of the file
            for i in xrange(360):
                az.write("%d\t%0.4f\n" % (i, db_to_norm(float(next(ant)))))
        with open(outfile + '.el', 'w') as el:
            # mechanical downtilt, azimuth of tilt
            el.write("%0.1f\t%0.1f\n" % (float(tilt), float(direction)))
            # Read the lines for elevations +10 through -90).
            # The rest of the .ant is unused.
            for i, line in enumerate(list(ant)[80:181], -10):
                el.write("%d\t%0.4f\n" % (i, db_to_norm(float(line))))


if __name__ == "__main__":
   main(sys.argv[1:])
