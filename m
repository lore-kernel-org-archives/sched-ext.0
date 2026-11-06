Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793982150;
	b=gqid0uagZb92C77LzLmBShB88lb7M/HIF97kMw09jFfEYRTy3j/UK74VD5EDaXxshfni
	 yrdc/SsXLMMwMP/zpfWqZR2kqLlf/TE5nn3PizMN99LhGZ3uY1AOA+uxmnbercmQxCpDG
	 JHetNV7u5B1lwjrKQ3o+NdQyngRqAG0x/DYVmXYP5sjgxz/GcF1DYiVThrOQjG/RzkwrA
	 PoaEME7q7VsFhn7Kh6Ob+q6HM0X3plW7IX+fvWAcygJlDt35tmDELtwe4/6tcbqYcdOEj
	 3b/mA7sK9te3HzjCWymv0aY9fgB0ul5CaOLGBuQ4A+A5g8jY8pN48uXNR+kcUQEvBfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793982150;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=5qoJPw+qIEyXRRR0ruoMunl9bad/9mwg4HzwIER48nI=;
	b=VwrCTHd7Or5e7WzfQv7KRbDH1YVp6qQAIcjtYtz2NRXTF452mW48/ce2c4FkNPfGk5TM
	 HA5K6vAp/ARcuaBXbqsRf6KTGc+H1rGNvpcGkZ6mWOAv8TtwLKWshP8tvxwvi1EzV3fCj
	 K/t/IFh/RCgngzDOhchazCRpLnTQkDbQHrpHdoh+jhce7TZHfVXhvwMphYHqLjfBozJBE
	 jzNl5Fb4DyAxyDvUedAeIja+vnpTWnRfHdsvle1vXc8hPqSquB861EIJVfMZhCjurvd3N
	 S9rkvYUf2otJn56NPUbTEm/8AnhJrnfKqRMM31xRmG2vRJhTTqL19RhDGE3XALEvakw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WBn+REG5;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C79606A326
	for <sched-ext@lists.linux.dev>; Fri,  6 Nov 2026 16:22:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0C79606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WBn+REG5
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a1bc97805eso859185e9.2
        for <sched-ext@lists.linux.dev>; Fri, 06 Nov 2026 08:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793982148; x=1794586948; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5qoJPw+qIEyXRRR0ruoMunl9bad/9mwg4HzwIER48nI=;
        b=WBn+REG5OYp5yaRrkagtK/POg0I8iWYdAlZYBvWkL3nwLh6rLyGWu601+0L/1bUSYI
         eLhpkS58iwNXwfw0kud4yxUdT5tNYtirP0OPUPqyjwxG5V8NH5lb7U4+IPg57eBdpkwA
         FdSQeFzVUEqd0GIvNRloYfqbhfNCz8x1NvrzTn2EiDFViIbGZ4ArhlQU9bc72ceagEdI
         LkdohvsBF2913EqYX1he/xaZaeQyqBL1x5RcUTjAzcWcW2QnADcwCtqCGcFDWEd25Dx5
         Ud7Lt40jP9PK2UTCVFo/07be+ac8om7VMKCFOnzQVMbF+hjW3KbVNWGJe3kuA+rHSvwf
         2NAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793982148; x=1794586948;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5qoJPw+qIEyXRRR0ruoMunl9bad/9mwg4HzwIER48nI=;
        b=dd/vutzmcm3qpOsaXYphQ5DNU1CVCW0Ty0DORyxdKp6xS8WMK/+S5SmqF1KvWelsOS
         fi/r76HZgWcN8kD2l2aLV7/Yi5MOjaTDsREVvJ2KLY2H1or0ewFUIHnwLIZrKgSuXeys
         5gXZMQunYVPeVkkNugHA9LRSqBeD74XKGH3teHhHsjeuRUaikV21y0iUn6SJ7EDTztQC
         nH+h+Zu2BTSbr5GmO+QvnXnKycr3D4P0yj3TFM2MSNKo+Ya4njciuc+sw6YcktktI2ur
         6ATcZ/zlpGFRRWmwvmeo5PVXv4BaN1+EfTwrv4KtDwLJZg+CtkfhkSrH78jdn/B+yGb9
         T5Tg==
X-Forwarded-Encrypted: i=1; AL+hErFkcl+X1vlpiIXUohoHirWFnJV81KUuzuvWg96nNU1ic0QK8zgOUyfg+dRoAriIbS2R6rlPGvVZUc4=@lists.linux.dev
X-Gm-Message-State: APuU4Z9QGRGIPqF82SLxlkks+nQ7N/OYQlLguLRdaN6zKiSkLkxKc7WG
	8ULJQHi6wXYYHtqV5868tpLAB8WaM6zlshSavVBd4gra7EcZp69WfL0s
X-Gm-Gg: AYBFou2UKtrUP5uODjLR6ZgzDzw869OB9zhHqMsnF5TkfRLbAQk4Wjt4F9N6qQXVmCx
	IQc+CEfFYdKycwtOW66C5tUYeEugXaA43HQ1y7qbi1hb8mkTrHrvpM81sThKFtcIeCsEE82MOHi
	SFCV8pZ20cFnZWp6NU+z9jGgvyvTBG8TpZ8xuhFH8DC+My8DWuGYxloKOHkpEG9mKKqIAs5YeHj
	Y75G1hLgUD1Sl1xPooJY6I/J6aW0GyDxqP5r0ps2kPENWBnwPjT2Zqt4JGIjbkAQ1uWmte1LD2I
	Htg236DbGtHUrhveDtyddDqSmWF/JJ5r83a9DuuFN35k2apmjEY8ienY4Ht03zPIrFa/upug2k+
	67YXEEd0syQi1Tm6XAq2d+sBTsAmAG8SO2E4c8brmnQQ3qkYSAW8WREzLdYl0h2xVqNFam92tDl
	w+EZOXWZxAntAPUjLqiY6FJIcd+VYX+ZdVoO/uBXS7amV5q7/6ThuIG33n4n6+mCGhTyLkbf++U
	h11o7XrRV4+5pzyHC0VYt3amRqhtr16SaCnDc9pgd1p1NJK500Brr+WNhj2s8qSoja/RzanJwdu
	V/23PgJmCHZa5vIb3jzZiIX2JhxeR8oEa4cpyuDHPz19iSyKk3+ltWU=
X-Received: by 2002:a05:6000:645:b0:48c:6611:82 with SMTP id ffacd0b85a97d-49272a3ab3fmr5316957f8f.1.1793982147441;
        Fri, 06 Nov 2026 08:22:27 -0800 (PST)
Received: from scheduler.schedules ([85.100.66.184])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d087a3c5sm3952650f8f.0.2026.11.06.08.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 08:22:26 -0800 (PST)
Date: Fri, 6 Nov 2026 19:22:22 +0300
From: Kayra Cizmeci <kayracizmeci@gmail.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, 
	vschneid@redhat.com, kprateek.nayak@amd.com, linux-kernel@vger.kernel.org, 
	lukasz.luba@arm.com, rafael@kernel.org, linux-pm@vger.kernel.org, tj@kernel.org, 
	void@manifault.com, arighi@nvidia.com, changwoo@igalia.com, 
	sched-ext@lists.linux.dev, qyousef@layalina.io, christian.loehle@arm.com, 
	pierre.gondois@arm.com, sshegde@linux.ibm.com, tim.c.chen@linux.intel.com
Subject: Re: [PATCH 02/20 v3] sched/eevdf: Reset lag at wakeup when prev CPU
 has been idle
Message-ID: <au38gSTzmvPKmqWT@scheduler.schedules>
References: <20261106151947.3991524-1-vincent.guittot@linaro.org>
 <20261106151947.3991524-3-vincent.guittot@linaro.org>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261106151947.3991524-3-vincent.guittot@linaro.org>

On Fri, Nov 06, 2026 at 04:19:29PM +0100, Vincent Guittot wrote:
> @@ -8376,6 +8383,9 @@ static bool __dequeue_task(struct rq *rq, struct task_struct *p, int flags)
>  
>  	dequeue_hierarchy(p, flags);
>  
> +	if (!(flags & DEQUEUE_SAVE) && !cfs_rq->h_nr_queued)
> +		cfs_rq->idle_seq++;

This needs WRITE_ONCE, no?  3/20 uses READ_ONCE().


Cheers,

Kayra

