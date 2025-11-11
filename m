Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037EF25C818
	for <sched-ext@lists.linux.dev>; Tue, 11 Nov 2025 14:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762873071; cv=none; b=cfdWBCOw/XfmcEhxTsZoYIVG0qx/dZS6W1VAei7NRQs64dkCfubqxB9uFp8n6sKHx1wi6N/+ks6GQi3AoYq4NOO7irUbiYzGBiewPAB12wP7hXW8BgUaMnBbLjye3jIGFCjWgQ2Vc8EYR9GSEDnH47zAywXtlw/ioiZ1aOo7n1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762873071; c=relaxed/simple;
	bh=zIAJYvFlnqjwTCcDLrwYuCJuNplcR5iWuYDi6bUO91g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hbkmsEOxkdthFpzQNK1ILajf/xq0FTfLmA6Yu/OHfpJIvGEBKqaZL5rnnJNEwx8WN0tL4ZUFA1pqOgL4dPGrqVzE5ZXldRHgI6pliC7/XHgWZd2xIg7P0tQevTKBzhcDWDfEbq/YJ5xzJ4Ja/EqoVFZ73aoOv7URY/A7synzVxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fnnyYRhC; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fnnyYRhC"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8824ce98111so28336046d6.0
        for <sched-ext@lists.linux.dev>; Tue, 11 Nov 2025 06:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762873069; x=1763477869; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EnKzJRxUMQswCpgDbIGddFJBw4T/v1HmQefMzOICXxw=;
        b=fnnyYRhCoYyG6u3Uv1mYA9gun7TVqGrSu6jXbjsZGlJSzm/a902ppvOKzzdX7Tnwq1
         EubwcNgH/IejpZCzsP2+GZJxKqlEbEfUOM0tDaDyU9pSlj7lhA/xsm5UDIPv6MV1AFeG
         YMvlP+XsehF8qrNiv5BzOybfzBWF+XGsc/+GeXQXZELdLvsqy2tOioNuc/bjeTaxs7kN
         Bk7M+VNnLoWt5gmY0DSYhocsuJEdVODxV+OXSCQSyNRxr+/GVdL9Thinzgj9u2YoctLB
         CHUJCeY17622CipSnsPgmhgsBTyBkuznbwZXBUq2ZINi49l+VsZBJEDr22ZV2m7vElJS
         25+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762873069; x=1763477869;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EnKzJRxUMQswCpgDbIGddFJBw4T/v1HmQefMzOICXxw=;
        b=BZXeqrTRcQymVEuGOId0E3VCzopJu8LfSJuy1NSjD0MGJjPFgBxJZs62zNS7iKhYz2
         dT1gYk58haSUKd4vN5ssb+IOICTWSWnTqOcQmawYJkWMHLn5z+epSSQjYno6eSMJjyAj
         Q0wzQWIZK0rtIvmB84aqVKUbVqWsIMC8iywAVX8kdIpr29Bq62sQIcFTrQ4lKQKc+D6F
         1+Yquc16INI7x0ZypB+MiBzRwEcDSLGPNzvGFZM0GGbnOgnOWa8bfmeQHXo+5Tk1QBaE
         4kY72rygwqXn7zYdh/lDFs1n61hFqkj7VgdamDMT/dr/JQvDYbnAcRAD9Kwmc/vF/s+t
         mRXA==
X-Forwarded-Encrypted: i=1; AJvYcCUBCyLKCgos2gxddeH/R/IdSeCWgq5IiMe3eBNXLG/HJ1TFJh26cSEniGJkIwOPKHCgpDP81S8SCvc=@lists.linux.dev
X-Gm-Message-State: AOJu0YzyfuVIdTYzW+H/vKjjrDmX+7sd6YZlnczK/vhrVIh/cg17DVvM
	9rK4upV2/BCyAzE08+nrHQy6A9Ycg9bfsFC8wugywWKA6vOkB1Rfemwl
X-Gm-Gg: ASbGncsHCU4WesHUlZbzCekwPD9UOaSSRp7jatQplxFXThwjXEN1mDTlHOSQwB+Xl7u
	O60p2rjXnT8zpgpeLI7d+7ehIvr2Db86xaqeXt8PbkAPD+qPbxgzkUsbCo4Hjcmbl3yfxmeWO+5
	LNwk8mZRFDCr0MMfAfAF+VsPkOieaD6RTSGG4Inm9opVFBJ9Ck4cdqi1anbgMXZ4bigQbXc5MRc
	Se5x+Ix01dqZOU9tbEobq9wfqoVwICrPTRca9GG3ZaZVcGwZTuzLhQgSaF/P1QqB+norKHHp77Y
	WDf9vQGbLwlGKp05Rz2nJil55a4J4CYNzmcs18V2RkzDACwVrGvzbBRyFJ9zwqdT69q80njKxF/
	3+mdytyL1AsPqqIjKg1tU4rthnzrlsbCEkAtEPHjcUquKExK/d5SnaZ8cQoR8VX2m0bf8f6xJDo
	WP6KICYEht5FXfQDuCN0y46XqH
X-Google-Smtp-Source: AGHT+IElMIyji7uPUvw6aoJovAxjkcTZAsKXd19Q2rmtiC7uMfNHOttDD/l5SXanUGpE43v9DnBlxw==
X-Received: by 2002:ad4:5be7:0:b0:880:545b:ab7b with SMTP id 6a1803df08f44-882385cffefmr194862386d6.4.1762873068873;
        Tue, 11 Nov 2025 06:57:48 -0800 (PST)
Received: from dschatzberg-fedora-PF3DHTBV ([2620:10d:c091:500::7:708f])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88238b742f0sm72171676d6.43.2025.11.11.06.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 06:57:48 -0800 (PST)
Date: Tue, 11 Nov 2025 09:57:46 -0500
From: Dan Schatzberg <schatzberg.dan@gmail.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <andrea.righi@linux.dev>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <etsal@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/13] sched_ext: Make slice values tunable and use
 shorter slice in bypass mode
Message-ID: <aRNO6j5B4RDugKfJ@dschatzberg-fedora-PF3DHTBV>
References: <20251109183112.2412147-1-tj@kernel.org>
 <20251109183112.2412147-3-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251109183112.2412147-3-tj@kernel.org>

On Sun, Nov 09, 2025 at 08:31:01AM -1000, Tejun Heo wrote:
> @@ -919,7 +948,7 @@ static void dsq_mod_nr(struct scx_dispatch_q *dsq, s32 delta)
>  
>  static void refill_task_slice_dfl(struct scx_sched *sch, struct task_struct *p)
>  {
> -	p->scx.slice = SCX_SLICE_DFL;
> +	p->scx.slice = scx_slice_dfl;

Do you need to use READ_ONCE here given that this can be modified concurrently?

>  	__scx_add_event(sch, SCX_EV_REFILL_SLICE_DFL, 1);
>  }
>  
> @@ -2892,7 +2921,7 @@ void init_scx_entity(struct sched_ext_entity *scx)
>  	INIT_LIST_HEAD(&scx->runnable_node);
>  	scx->runnable_at = jiffies;
>  	scx->ddsp_dsq_id = SCX_DSQ_INVALID;
> -	scx->slice = SCX_SLICE_DFL;
> +	scx->slice = scx_slice_dfl;
>  }
>  
>  void scx_pre_fork(struct task_struct *p)
> @@ -3770,6 +3799,7 @@ static void scx_bypass(bool bypass)
>  		WARN_ON_ONCE(scx_bypass_depth <= 0);
>  		if (scx_bypass_depth != 1)
>  			goto unlock;
> +		scx_slice_dfl = scx_slice_bypass_us * NSEC_PER_USEC;

Similarly WRITE_ONCE here

>  		bypass_timestamp = ktime_get_ns();
>  		if (sch)
>  			scx_add_event(sch, SCX_EV_BYPASS_ACTIVATE, 1);
> @@ -3778,6 +3808,7 @@ static void scx_bypass(bool bypass)
>  		WARN_ON_ONCE(scx_bypass_depth < 0);
>  		if (scx_bypass_depth != 0)
>  			goto unlock;
> +		scx_slice_dfl = scx_slice_dfl_us * NSEC_PER_USEC;

And here

>  		if (sch)
>  			scx_add_event(sch, SCX_EV_BYPASS_DURATION,
>  				      ktime_get_ns() - bypass_timestamp);
> @@ -4776,7 +4807,7 @@ static int scx_enable(struct sched_ext_ops *ops, struct bpf_link *link)
>  			queue_flags |= DEQUEUE_CLASS;
>  
>  		scoped_guard (sched_change, p, queue_flags) {
> -			p->scx.slice = SCX_SLICE_DFL;
> +			p->scx.slice = scx_slice_dfl;

And here
>  			p->sched_class = new_class;
>  		}
>  	}
> -- 
> 2.51.1
> 
