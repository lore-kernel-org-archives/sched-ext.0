Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECC8347FC0
	for <sched-ext@lists.linux.dev>; Sun, 18 Oct 2026 06:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792306684; cv=none; b=qIITdaDNqiMTyOZjvez+nZ1kK7eQ1Fikk/OcBiPCWkb+nHLDGwYNDHgNj3wXEIDjTG7I1Win3BqoieFT7wkfaOb2+MLLSK4vpnIG92MmZDYtUYgU8Wo4zl6/Hfc0oHTgc7pVqrSaSngpMt6ynWfqnHlHLC/shhWqtOhGn5vH1dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792306684; c=relaxed/simple;
	bh=n8drFyWUqlZVAL8+M5tEtJElOJELGas4rwhBBwINCmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Myu6wTBjC0NpOsscV6z3OJpXrtJAYWEpSMHG45u2SEBkUGW/MMa0TGh5M87os7gMR4E95xzk0mbaXzx1ZQ+59/VbgJ/VCGNQYag48grTftv/8FYF2SQKAHc/gOob/YJqCGmARq72PkBUHsviExxtgUpQldY1m9Wc52Cbsi+CiiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OpxHOMYG; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OpxHOMYG"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-48df4f7ccf4so143343f8f.1
        for <sched-ext@lists.linux.dev>; Sat, 17 Oct 2026 23:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792306681; x=1792911481; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HwdW3HA63E3gYfbgiIewlrhU22u3aiecjGG8syRP8fE=;
        b=OpxHOMYGQ8okGNbS7m4x8O2zx+Fi80vFVY/hSjOOLj04hUFD2uFris+ixxa6SQdUSe
         gIFzNqXKTYUjvZU5PYa2/fLzzk/Kd5AQZO40ITCdTzs8bdbs3TUHG4o32H3cBSVidXhl
         AagPxj0yWYsBDWtXJdz/pOWJ06Fc6AhQ5Lqq3r043VGcx4GgmcZRB5Un9xnPGHANJSoM
         FBAV6+6kCiXO5nfu/V7+iO8wX59cdtQ7YPkPtKk6IQpJhGcG2Mx/1zw0waUq2NmebkR4
         w2VMeOprFRe6QDGNT5Bu0KoK39VOvwbWe6nabki+bYA9DL3tX372pJIhAEzjr34DDwxU
         3IQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792306681; x=1792911481;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HwdW3HA63E3gYfbgiIewlrhU22u3aiecjGG8syRP8fE=;
        b=oc6dadViVG4H9qJYYNgrqtWeJ2utbgnNKwhYXdQzWnKp0NYpSsNMkTxksfvhyXGAUq
         Og6T35dxdZi8XwcnISnnyn53oqA28YQizQdz16j2lxlICWjANBG4L+sRDMJnoT9o1UhL
         90tgiGpRHk8k6fLs35nIqD5/gZ0M0fb8m98BbQkDo4W3JFkBdp+XB8dDn3Vnoc8RnSlF
         a9OHf0CnKtP00T8+jFJ9MS4F8epUUJijzndVhQXHkn5btyZEv6k/vWvyp39uZN7JGea4
         MYSW1meefcYp1r0FU7dh3eZ+o5juWAbRfqK+9U1LRgffSyJqN0hEZHIRQfN72KxG4Wzk
         d7hg==
X-Forwarded-Encrypted: i=1; AKwUvBzoJJ0/Oh2IFSSSAqlG1tO8zYwxv1wqH853gqiPlb3sAtoQxJJo4QPKGdw5KwIVSKXPGPBnO9y7fjs=@lists.linux.dev
X-Gm-Message-State: AFq9FYLudOt0K5RcdvBrnWSjSYq/6uvXBKgp1tj9cAVvqd8BkAIO9Zqw
	rIx2IwStvPARrYLiPbz3ktJ9be9niaULKZmxEFQIQShrG+ajsJoxGLvj
X-Gm-Gg: AYBFou3/2LuC6hNFSBj+5Uj3GYERMJZvqkIE8jhiX6zA2Yxd6oSFwvwAoQRq97pn1Gb
	TQI6n86RfhxP3JpEqv+Wx8cEVw4Dc43lMB/0lSyqtGEHwHA/mPRmLGip4oOV0F1Kk7/6HItusyW
	Af2B6sHhyGXYVw7ug0TFOTIkVQ+yCFG83CksxJE13d++s81cx+Sl107vLiPPDW8S7ccdwXEFqzu
	V8F1oi2VMJUy8zCra7FuiRYwRw0zU1YutbZWZS/N7rOp/LyC2EP/SqkZIBWWIiJyV/PSo+kDRGG
	vZEm2riJVhVmxGZbfS3Lpy6M6OrcT1EVdtoFaTvK7kOCgguUdJmcFCSEdC42TD9fMMsa/ErUNvE
	yCIb+TymwgbE7R15CoW9pcGJHPB0RF/Go7ZucqBpKFU7KvcCNQNLAcRgjsILz6fr9Ve5OvmCPVQ
	b71rokPx+d4HKVVZrzX8Sb5tniaT9d4GDjFC/Ghy4bWfiraJmeX3NQUO2w8Fw4j3H7BzolAIxr+
	f6WV04nAYU4vjnLyTcQYlpRXA==
X-Received: by 2002:a05:6000:2882:b0:48a:f5c5:d077 with SMTP id ffacd0b85a97d-48e07b9ca18mr8627716f8f.2.1792306681279;
        Sat, 17 Oct 2026 23:58:01 -0700 (PDT)
Received: from scheduler.schedules ([85.100.66.184])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd4c5942sm22345732f8f.16.2026.10.17.23.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 23:58:00 -0700 (PDT)
Date: Sun, 18 Oct 2026 09:57:57 +0300
From: Kayra Cizmeci <kayracizmeci@gmail.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, 
	vschneid@redhat.com, kprateek.nayak@amd.com, linux-kernel@vger.kernel.org, 
	lukasz.luba@arm.com, rafael@kernel.org, linux-pm@vger.kernel.org, tj@kernel.org, 
	void@manifault.com, arighi@nvidia.com, changwoo@igalia.com, 
	sched-ext@lists.linux.dev, qyousef@layalina.io, christian.loehle@arm.com, 
	pierre.gondois@arm.com, sshegde@linux.ibm.com
Subject: Re: [PATCH 07/18] sched/fair: Add push task mechanism for fair
Message-ID: <atRseHwvpRJGtjIy@scheduler.schedules>
References: <20261002154415.2270586-1-vincent.guittot@linaro.org>
 <20261002154415.2270586-8-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261002154415.2270586-8-vincent.guittot@linaro.org>

On Fri, Oct 02, 2026 at 05:44:04PM +0200, Vincent Guittot wrote:
> +static void __fair_add_pushable_task(struct rq *rq, struct task_struct *p)
> +{
> +	plist_del(&p->pushable_tasks, &rq->cfs.pushable_tasks);
> +	plist_node_init(&p->pushable_tasks, p->prio);
> +	plist_add(&p->pushable_tasks, &rq->cfs.pushable_tasks);
> +}
> +
> +static void fair_add_pushable_prev(struct rq *rq, struct task_struct *prev, struct task_struct *next)
> +{
> +	if (sched_push_task_enabled() && fair_check_pushable_task(rq, prev, next))
> +		__fair_add_pushable_task(rq, prev);
> +}
> +
>  /*
>   * select_task_rq_fair: Select a target runqueue for the task.
>   * There are 2 ways to select the target runqueue:
> @@ -10272,6 +10426,12 @@ static void put_prev_task_fair(struct rq *rq, struct task_struct *prev, struct t
>  	cfs_rq->curr = NULL;
>  	if (se->on_rq)
>  		__enqueue_entity(cfs_rq, se);
> +
> +	/*
> +	 * The previous task might be eligible for being pushed on another cpu
> +	 * if it is still active.
> +	 */
> +	fair_add_pushable_prev(rq, prev, next);
>  }
>  
>  /*



Re-reviewed this :-)

On our rq, we have a fair task TA that holds M mutex. we have a RT task TB blocked on M. 
we enter __schedule() and from there pick_next_task(). it chooses TB as next, but it adds 
TA to the pushable task list. then we enter the proxy exec path. 
donor is set to TB. but when we enter find_proxy_task(), next is changed to
TA. so right now, TA is on the push list even if its still curr.

(With the whole series applied.)

Am I missing something? Should curr not be pushed?

Thanks,


Kayra
