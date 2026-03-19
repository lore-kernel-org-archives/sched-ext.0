Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C5C34D383
	for <sched-ext@lists.linux.dev>; Thu, 19 Mar 2026 13:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773928478; cv=none; b=PBW+TAu+RAVVCGuwCcDDzyZIjrphIwMUTDnWStE1zauv6ypMj3jtMN34qLbdVfzB9s6L+hE6n9kyHQ1Oh4RZfkAL+M1eZllv79HUh51fa76rD36Iwxj6u/UhmX5GWzLct+ATHpVOguEvt/cIh/w0Fb4Ma1j+FnvdX+RMVIdcGBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773928478; c=relaxed/simple;
	bh=nEiSLs2H3Kvd1s/vRGu/XZ2J2WewS2gX5to8YkkCZ/o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sc+tP8EayMvf5BYTsg0AQiydkB/866qbHmRbZ6kMZmQjDfpzUihtunbJugUvMKUcPdlg3P4eEbm3d/42vj0gIfWnA/6N7xyk7NCD09PyMUUiKBH5Z1/UsJuKwfMTXW+oJX4Pzt50hwNDjm+JExfYV+v3d0P+L0DeSaSf3fvj8Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=II1bljVG; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="II1bljVG"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-486fa35b005so8934695e9.2
        for <sched-ext@lists.linux.dev>; Thu, 19 Mar 2026 06:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773928474; x=1774533274; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fV8dT3x1VQ3HsGvnNM5pFRRVLSQGVidD/Hn7+GzBMdw=;
        b=II1bljVGx5rv27k+o/eYamz24xmF0OehgtDLEe1PjAaU6148v+gU4NuvqOVRWci0BZ
         qjx+xAoiqPcZu3l3JX4lNnpY9XZ41fpSo+YKzMV0S1r3EklU5STm23v/rHNU1hsK6UW0
         vT+WNattZnBk7eniyGEJszsNKD3GNEFGkZZHtvGqrYMLb4oP3lV1UITg/vwscwjzUM1C
         TVscBq1j0+XhewfdeweWbZ8iMn8HbuvaAc7NFZMjfrX7yQpcbylkmXGe8mRJyLNLbTkd
         Wwp3Pign+MuK6QSGe/N5Fvnp8/ye9WY5q8mPFAuv+Jk4SSFyIm3HS89aV18EqZYSix90
         5Jww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773928474; x=1774533274;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fV8dT3x1VQ3HsGvnNM5pFRRVLSQGVidD/Hn7+GzBMdw=;
        b=eToXyinYY1A9+q17DsLVuiDyLq7uzk+4d+YsJOmEQ9WFm0RT3GXwHNip2fXO753z5z
         TLKH4YnBtu8ZG3O376IIfBrmY8rNC892qlKDB8ooVfhf2L9SioBKERe1K8YRnpXOolc+
         HI0+lWAIMWdgLS8R9kKB0bAu8ul3iTS96Ly4p0gx53FiMFQ7MhidSLNWxIRIwHkzAOfO
         RpnZDnY0uj5u1X2QlEbH8OxL34fDQG1pDmJykFzp+OgVq3SjIhOXcL1RKA18dXKdlqFP
         RexuPKeqWnb8p+OLQGLxpeNdx5K0CKSZbbPQOl04LNMiqPjWwJ1NXs9CLokGAnepw8Z9
         L8Ww==
X-Forwarded-Encrypted: i=1; AJvYcCU3I2TImqpwcCBljbgFu9oui8Ths06c/qucfdWuojd44u5pf/T0L6PZnr9m4U7ughdf+ntUbhPmukc=@lists.linux.dev
X-Gm-Message-State: AOJu0YyzU5fDSIm6KOK1FgaWXjmv0kQ3/W/D30oncX/d+vM7zyI+Tsyj
	scON11lmyd8dPsAsKeGpNf89JqkhhKdZn37rLWxy9AKmnVXH5/2yRxR65fhbaOUC+0gI9uPotxn
	+BWBZKWLK2/gAmw==
X-Received: from wmdd14.prod.google.com ([2002:a05:600c:a20e:b0:480:6b05:6b9a])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:c491:b0:485:3f58:d9f with SMTP id 5b1f17b1804b1-486f4465d04mr124104415e9.30.1773928473659;
 Thu, 19 Mar 2026 06:54:33 -0700 (PDT)
Date: Thu, 19 Mar 2026 13:54:32 +0000
In-Reply-To: <DH6OUDJUQNA3.6L4YXJMME4KI@google.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260319083518.94673-1-arighi@nvidia.com> <DH6OUDJUQNA3.6L4YXJMME4KI@google.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
Message-ID: <DH6T5U5G4AZ1.38Q2K35KN0ET5@google.com>
Subject: Re: [PATCH v2 sched_ext/for-7.1] sched_ext: Invalidate dispatch
 decisions on CPU affinity changes
From: Kuba Piecuch <jpiecuch@google.com>
To: Kuba Piecuch <jpiecuch@google.com>, Andrea Righi <arighi@nvidia.com>, Tejun Heo <tj@kernel.org>, 
	David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>, Christian Loehle <christian.loehle@arm.com>, 
	Daniel Hodges <hodgesd@meta.com>, <sched-ext@lists.linux.dev>, 
	<linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu Mar 19, 2026 at 10:31 AM UTC, Kuba Piecuch wrote:
>> @@ -2537,9 +2546,26 @@ static void dispatch_to_local_dsq(struct scx_sched *sch, struct rq *rq,
>>  	}
>>  
>>  	if (src_rq != dst_rq &&
>> -	    unlikely(!task_can_run_on_remote_rq(sch, p, dst_rq, true))) {
>> -		dispatch_enqueue(sch, rq, find_global_dsq(sch, task_cpu(p)), p,
>> -				 enq_flags | SCX_ENQ_CLEAR_OPSS | SCX_ENQ_GDSQ_FALLBACK);
>> +	    unlikely(!task_can_run_on_remote_rq(sch, p, dst_rq, false))) {
>> +		/*
>> +		 * Affinity changed after dispatch decision and the task
>> +		 * can't run anymore on the destination rq.
>> +		 *
>> +		 * Drop the dispatch, the task will be re-enqueued. Set the
>> +		 * task back to QUEUED so dequeue (if waiting) can proceed
>> +		 * using current qseq from the task's rq.
>> +		 */
>> +		if (src_rq != rq) {
>> +			raw_spin_rq_unlock(rq);
>> +			raw_spin_rq_lock(src_rq);
>> +		}
>> +		atomic_long_set_release(&p->scx.ops_state,
>> +			       SCX_OPSS_QUEUED |
>> +			       (src_rq->scx.ops_qseq << SCX_OPSS_QSEQ_SHIFT));
>> +		if (src_rq != rq) {
>> +			raw_spin_rq_unlock(src_rq);
>> +			raw_spin_rq_lock(rq);
>> +		}
>>  		return;
>>  	}
>
> My understanding is that task_can_run_on_remote_rq() can run without src_rq
> locked, so it's possible that @p's cpumask changes after the check, isn't it?
> In that case, I think it's still possible to move the task to the local DSQ
> of a CPU that is outside of its cpumask, triggering a warning in
> move_remote_task_to_local_dsq().

I've looked at the code more carefully and I don't think this is an issue.
It's true that task_can_run_on_remote_rq() can run without src_rq locked, and
it's possible that the cpumask changes after the check, but then the dequeue
preceding the cpumask change must have waited for ops_state to change from
SCX_OPSS_DISPATCHING to SCX_OPSS_NONE and it must have reset holding_cpu to -1,
so thanks to the holding_cpu check later we won't insert the task into the DSQ.

Apologies for the confusion.

