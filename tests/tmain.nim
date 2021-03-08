#[
adapted from https://github.com/nim-lang/Nim/issues/5685
]#

import std/[os,osproc,compilesettings,strformat,sequtils]

proc genMegatest(files: seq[string]): string =
  # xxx this could be moved to some reusable `std/testutils`
  # xxx testament.megatest also adds intermediate files for inserting `echo`
  # so we can compare outputs in an ordered way; this could be done here too.
  proc quoted(a: string): string = result.addQuoted(a)
  for file in files:
    result.add &"import {file.quoted}\n"

proc nimCompileWithSameOptions(file: string, options = "", input = "", command = "r") =
  let cmd = fmt"{getCurrentCompilerExe()} {command} -b:{querySetting(backend)} {options} {file}"
  var (output, status) = execCmdEx(cmd, input = input)
  doAssert status == 0, &"cmd: {cmd}\ninput: {input}\noutput: {output}\nstatus: {status}"

proc main =
  let code = filterIt(toSeq(walkFiles("examples/*.nim")), it.lastPathPart != "gtk_quartz_ex1.nim").genMegatest
    # running fails on osx: could not load: (libgtkmacintegration.2.dylib|libgtkmacintegration-gtk2.2.dylib)
  nimCompileWithSameOptions("-", options = "-d:gtk2DisableMain", input = code)
  nimCompileWithSameOptions("examples/gtk_quartz_ex1.nim", options = "--usenimcache -d:gtk2DisableMain", command = "c")
    # TODO: use -r:off instead, pending https://github.com/timotheecour/Nim/issues/639
main()
