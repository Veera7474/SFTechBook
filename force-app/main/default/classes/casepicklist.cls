public class casepicklist
{
    public static void casehelper(List<case> newList)
    {
        system.debug('newList'+newList); 
         List<Case> rt =[SELECT CaseNumber
                        FROM case
                       ];
         List<task> taskList=[SELECT WhatId
                             FROM Task
                            ];
        System.debug('rt'+rt);
    }
}