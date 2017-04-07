package com.odtu.mms.listener;

import org.hibernate.event.PostLoadEvent;
import org.hibernate.event.PostLoadEventListener;
import org.springframework.stereotype.Component;


@Component
public class CustomPostLoadEventListener implements  PostLoadEventListener  {
    
	@Override
    public  void onPostLoad (PostLoadEvent  event)  {
        final  Object  object  =  event. getEntity ();
//        if (object  instanceof  KurulusDenetim) {
//            ((KurulusDenetim)  object).postLoad ();
//        }
    }


}
