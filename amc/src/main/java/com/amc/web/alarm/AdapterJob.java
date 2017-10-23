package com.amc.web.alarm;

import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

public class AdapterJob implements Job{

	public AdapterJob() {
		
	}

	@Override
	public void execute(JobExecutionContext context) throws JobExecutionException {
		
		AlarmPush.getApplicationContext().getBean(AlarmPush.class).run();
	}
}
