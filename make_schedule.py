#!/usr/bin/env python3

import sys, json, itertools

def make_internal_header(fields):
    return """
  <tr class="active">
    <td colspan="4" class="active">{}</td>
  </tr>""".format(fields[0])

def make_schedule_row(fields, lessons):
    date = fields[0]
    topics = ""
    readings = ""
    if fields[1] in lessons:
        lesson = lessons[fields[1]]
        topics += lesson["topic"]
        for reading in lesson["readings"]:
            readings += reading + "<br/>"
        for resource in lesson["resources"]:
            readings += resource + "<br/>"
    else:
        topics += fields[1]
    reminders = fields[2] if len(fields) == 3 else ""
    return """
  <tr>
    <td>{}</td>
    <td>{}</td>
    <td>{}</td>
    <td>{}</td>
  </tr>""".format(date, topics, readings, reminders)

if __name__=="__main__":
    schedule_spec = sys.argv[1]
    course, semester = schedule_spec.split(".")
    lessons = json.load(open("{}.json".format(course), "r"))
    fin = open(schedule_spec, "r")
    out = ""
    lines = [l.strip("\n") for l in fin.readlines()]
    header_divide = lines.index("BEGIN_SCHEDULE")
    for header in lines[:header_divide]:
        out += header + "\n"


    out += """
<div class="table-responsive">
<table class="table table-bordered table-hover">

  <tr class="table-header active">
    <th>Date</th>
    <th>Topics</th>
    <th>Reading and Resources</th>
    <th>Reminders</th>
  </tr>"""
    for sched in lines[header_divide + 1:]:
        fields = [f.strip(" ") for f in sched.split(";")]
        if len(fields) == 1:
            out += make_internal_header(fields)
        else:
            out += make_schedule_row(fields, lessons)

    out += """
</table>
</div>"""
    fout = open(semester +".html", "w")
    fout.write(out)
