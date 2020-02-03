#!/usr/bin/python3

import os
import sys
import argparse

class Hardcloud:

  def __init__(self, target, level):
    self.target    = target
    self.level     = level
    self.base_path = os.path.abspath(os.path.dirname(__file__))
    self.project   = os.getcwd().split('/')[-1]

  def new_project(self, project):
    self.project = project

    try:
      os.mkdir(project)

      os.system('cp -r ' + \
          self.base_path + '/template_rtl_kernel/ ' + \
          project + '/rtl_kernel/')

      os.system('cp -r ' + \
          self.base_path + '/template_hls_kernel/ ' + \
          project + '/hls_kernel/')

      os.system('cp -r ' + \
          self.base_path + '/template_sw/ ' + \
          project + '/sw/')

      os.system('sed -i s/loopback/' + project + '/g ' + project + '/sw/src/main.cpp')

    except Exception as e:
      print("[hardcloud][error] " + str(e))

  def compile_rtl(self):
    os.system('cp rtl_kernel/config/link.ini tmp/link.ini')

    os.system('vivado -mode tcl -source rtl_kernel/config/generate.tcl')

  def compile_hls(self):
    os.system('cp hls_kernel/config/link.ini tmp/link.ini')

    os.system('v++ --target ' + self.target + ' \
        --compile \
        -I"hls_kernel/src/" \
        --config hls_kernel/config/compile.ini \
        -o "tmp/hardcloud_top.xo" hls_kernel/src/hardcloud_top.cpp')

  def build(self):
    os.system('rm -rf tmp/')

    os.system('mkdir output')
    os.system('mkdir output/logs')
    os.system('mkdir tmp')

    os.system('cp ' + \
        'rtl_kernel/src/* ' + \
        'rtl_kernel/hardcloud_top_ex/imports')

    if self.level == 'rtl':
      self.compile_rtl()
    elif self.level == 'hls':
      self.compile_hls()

    os.system('v++ --target ' + self.target + ' \
        --config tmp/link.ini \
        --link \
        --remote_ip_cache tmp/ip_cache \
        -o "output/' + self.project + '.xclbin" tmp/hardcloud_top.xo')

if __name__ == '__main__':

  parser = argparse.ArgumentParser(description='HardCloud SDx Scripts')

  parser.add_argument('--new_project', help='create new project')
  parser.add_argument('--build'      , action='store_true', help='build system')
  parser.add_argument('--target'     , choices=['hw', 'hw_emu', 'sw_emu'], help='set target')
  parser.add_argument('--level'      , choices=['rtl', 'hls'], help='set level')

  args = parser.parse_args()

  if len(sys.argv[1:]) == 0:
    parser.print_help()
    parser.exit()

  obj = Hardcloud(args.target, args.level)

  if args.new_project is not None:
    obj.new_project(args.new_project)

  elif args.build == True:
    obj.build()

# taf!

