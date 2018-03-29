# Postgresql + Pgagent

## Usage
```bash
docker run -p 5432:5432 chiavegatto/postgres-pgagent
``` 

**Create a job example**
> Create a table with simple timestamp column.
```sql
CREATE TABLE public.pg_agent_test
(
  dt timestamp without time zone
);
```

> Create a job named `pg_agent_test_job`.
```sql
INSERT INTO pgagent.pga_job (jobid, jobjclid, jobname, jobdesc, jobenabled, jobhostagent)
SELECT 1, jcl.jclid, 'pg_agent_test_job', '', true, ''
FROM pgagent.pga_jobclass jcl WHERE jclname='Routine Maintenance';
```

> Create a step for `pg_agent_test_job` job.
This step insert a new date on table `pg_agent_test`.
```sql
INSERT INTO pgagent.pga_jobstep (jstid, jstjobid, jstname, jstdesc, jstenabled, jstkind, jstonerror, jstcode, jstdbname, jstconnstr)
SELECT 1, 1, 'pg_agent_test_step', '', true, 's', 'f', 'INSERT INTO public.pg_agent_test(dt) VALUES (now());
', 'postgres', '';
```

> Create a schedule for `pg_agent_test_job` job.
This schedule will run every minute, hour, day and month until 2019-03-31.
```sql
INSERT INTO pgagent.pga_schedule (jscid, jscjobid, jscname, jscdesc, jscminutes, jschours, jscweekdays, jscmonthdays, jscmonths, jscenabled, jscstart, jscend)
VALUES(1, 1, 'pg_agent_test_schedule', '', '{t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t}', '{t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t}', '{t,t,t,t,t,t,t}', '{t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t}', '{t,t,t,t,t,t,t,t,t,t,t,t}', true, '2018-03-28 00:00:00', '2019-03-31 00:00:00');
```
