package com.vhs.aspects;

public aspect Logger {
	
	pointcut logger() : 
		call( * com.vhs.factory..*(..)) ;
	
	before(): logger(){
		System.out.println("[AspectJCall] - Se llama el procedimiento: " + thisJoinPoint.getSignature().getName());
	}
}
