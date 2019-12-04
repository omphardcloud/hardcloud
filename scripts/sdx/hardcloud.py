#!/usr/bin/python3

import os
import sys
import argparse

class Hardcloud:

  def __init__(self, config):
    self.config    = config
    self.base_path = os.path.abspath(os.path.dirname(__file__))
    self.project   = os.getcwd().split('/')[-1]

  def new_project(self, project):
    self.project = project

    try:
      os.mkdir(project)

      os.system('cp -r ' + \
          self.base_path + '/template_rtl_kernel/ ' + \
          project + '/rtl_kernel/')
    except Exception as e:
      print("[hardcloud][error] " + str(e))

  def build(self):
    os.system('rm -rf tmp/')

    os.system('mkdir output')
    os.system('mkdir output/logs')
    os.system('mkdir tmp')

    os.system('cp ' + \
        'rtl_kernel/src/* ' + \
        'rtl_kernel/hardcloud_top_ex/imports')

    os.system('vivado -mode tcl -source rtl_kernel/generate.tcl')

    os.system('xocc -t hw_emu \
        --platform xilinx_u200_xdma_201830_2 \
        --sp hardcloud_top_1.m00_axi:DDR[0] \
        --sp hardcloud_top_1.m01_axi:DDR[1] \
        --save-temps \
        -l \
        --nk hardcloud_top:1 \
        -g \
        --messageDb tmp/binary_container_1.mdb \
        --xp misc:solution_name=link \
        --temp_dir tmp/binary_container_1 \
        --report_dir output/reports \
        --log_dir output/logs \
        --remote_ip_cache tmp/ip_cache \
        -o "output/' + self.project + '.xclbin" tmp/hardcloud_top.xo')

if __name__ == '__main__':

  parser = argparse.ArgumentParser(description='HardCloud SDx Scripts')

  parser.add_argument('--new_project', help='create new project')
  parser.add_argument('--build'      , action='store_true', help='build system')
  parser.add_argument('--config'     , choices=['system', 'emulation_hw'], help='set configuration')

  args = parser.parse_args()

  if len(sys.argv[1:]) == 0:
    parser.print_help()
    parser.exit()

  obj = Hardcloud(args.config)

  if args.new_project is not None:
    obj.new_project(args.new_project)

  elif args.build == True:
    obj.build()

# taf!

