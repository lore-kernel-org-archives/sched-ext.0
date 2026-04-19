Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8247F2D5C8E
	for <sched-ext@lists.linux.dev>; Sun, 19 Apr 2026 18:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776622264; cv=none; b=nWcpDfx25FQ1Gnt6a83RkT06VzIg5GJVsK7kZX1QGzeLwBTa+1J5dPf8qljTVASBlPQGQhmwlU6Z22mVIxg0AcjA8VaYo+BNfvFixHaZPr3f2m6iV9NSRy91uLmoXGGxGXkC1vSGmd8/2ulFR1+mxd28O70m4DtHCXswG/REnPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776622264; c=relaxed/simple;
	bh=vaop3+tKUYG+OFHgFaxjNNUoFa+r1iuv4qVKaUQdM3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qEOmnxGQha6oPHkIkqrqY79WTAS6sUahqxcUUCF1gzTlLQVNlGoKiwXbOanrMXFSd9o/dJ/9vy5CXDh7iS+LVCy5WOIhiuaCUjkunG4I445Wj/W/Hz5VJv04Qt3smOvB2EfLHUjVLYhQTYPfDcYxrpUO7Uwb50C2SEIcA9pqVbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aNBOoFxt; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aNBOoFxt"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ad9f316d68so9300205ad.2
        for <sched-ext@lists.linux.dev>; Sun, 19 Apr 2026 11:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776622263; x=1777227063; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LVsyHUcW/CGIzBJe8BryrCxfCjSbQMtYSPcW16KpKLk=;
        b=aNBOoFxtPD1WjYnO4zjxtSszfB4DtLNCZPv93vIAWReZeEu3btqAGXx0MZB+uhh4HQ
         10117BmjRDcT8mhKhO2TbJHNnQMyt1Ax2u1HKNLdPiezIEj54kkHLnNSwqrMbZj8I68V
         HCcX2LYiqaEAMgH8zr0CKK57Ti1UG8wHL0fhsTSOldGnRxB/kOujGaqUny0QT99kouz5
         CVhm1DsKIojVl64/1a08209loLRVRXzqPjyFdGyjWeW46od10Z/6dNJEKtSpdxHH5HGn
         fqECTM689hKR323LPWbRb+NOi6kCuwxVPEdEWzGU34k9/8C325k4lYqV8AJ9EQxtldsU
         jWPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776622263; x=1777227063;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LVsyHUcW/CGIzBJe8BryrCxfCjSbQMtYSPcW16KpKLk=;
        b=P5Zw98+m+OgkAPsJOx63NwdDgvq+4z5DUgyNbpVEWy2P1uzPoiNvFOAGoZX0lZSzcK
         uppoMD7yPMqk1KZRjBkO3rSxProqqv+upx1TACqn5ILk8erPVd/U0cLSrGKhp6hcVgpx
         C+tDCqUD+TsSl256Jvn/bzsFi/JxO2VfjMbhIkD61VU9LGilFxXQ/TIFALKyIZyGLbBc
         O0xU2maHIGQApUJw83VBfblOlYfmh7D3UcTlDTcoGCBlyHKw0KkAlVHgA/bgJtirEF8A
         I6kEtPQauQwlDlbmSIZGX/R7rILFX7sZGzZsCXYaEWdFLMwwvQEsoCLXuXSN2WMPYiui
         5pkQ==
X-Forwarded-Encrypted: i=1; AFNElJ9UMbf5nUerB85nF1qoJIgZZ5QbwE+8fTOigKD+1+BZNuASl7NMDfui+UZ/6HjO/ODeboa1SPm9qUc=@lists.linux.dev
X-Gm-Message-State: AOJu0YzZ4gx48VsLC3/KGiMFtjU618Lr212p4HGIAWYukzdap4Ybocx4
	BIAwvsJaugxmYNgk0DqsVLSkQvYRDDjoBsSArpUex1btLPQ2TGzBxq1M
X-Gm-Gg: AeBDiest6ORrdhiLUOny/zebYwcn2tlqmDODknTZWQmkp4qXSClTbApQHpXY7goCNcb
	c264qf79D8lGeZg75ayptidYz2F3qsCaKJmKptf6EFoCXqElxbepvlRr2s+t+Ei40Hs59bNIMUb
	fvS0e/F325ClW41w4TXJ37KEm6fnlBzfC0ar6hcrzNshdc99StMny3MIAPNnE4tz3CSn6mx2tXT
	06xGgLc9RmYeIfltpu2tPmz+gcsfEC15700dZtY+h6RvVPH+3l/0M9mrmYQYaIGAY32kk4d17up
	I4BxElCBUBe8PfYaeyo5ERd7PKrwq9lKEjIaEm+NifQRUhdZ8DqWfy9ifTXQ1wEpTACNL3QnBQA
	C/24Qu4Ea6xBfO16mlXyJDYVxSXZxE9I3Kr4SRRlvbkM9Hy17bJMPfe3eU99E13xAFGSs0HBDVM
	CFXK0XAs/VU+sUe0iPE9EV587+f5t9n78YTrgBKzoJmimwzT4KWGpMNjIAaTB+2GqzHapwkWSHi
	GyVnEEmVpci648M
X-Received: by 2002:a17:903:3d50:b0:2b2:596d:594 with SMTP id d9443c01a7336-2b5f9e8cda7mr71551705ad.13.1776622262769;
        Sun, 19 Apr 2026 11:11:02 -0700 (PDT)
Received: from cchengyang.duckdns.org (36-225-119-66.dynamic-ip.hinet.net. [36.225.119.66])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab40786sm85364565ad.79.2026.04.19.11.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 11:11:02 -0700 (PDT)
Date: Mon, 20 Apr 2026 02:10:58 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev, 
	Emil Tsalapatis <emil@etsalapatis.com>, linux-kernel@vger.kernel.org, 
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>, Chia-Ping Tsai <chia7712@gmail.com>
Subject: Re: [PATCH sched_ext/for-7.2] sched_ext: add p->scx.tid and
 SCX_OPS_TID_TO_TASK lookup
Message-ID: <20260420015438.G7a71@cchengyang.duckdns.org>
References: <a19c8c74d7c767bc9865b75d6de7c723@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a19c8c74d7c767bc9865b75d6de7c723@kernel.org>

Hi Tejun, sorry for the noise

On Sun, Apr 19, 2026 at 06:18:46AM -1000, Tejun Heo wrote:
[snipped]
>  void scx_pre_fork(struct task_struct *p)
>  {
>  	/*
> @@ -3682,6 +3732,8 @@ int scx_fork(struct task_struct *p, stru
>  
>  	percpu_rwsem_assert_held(&scx_fork_rwsem);
>  
> +	p->scx.tid = scx_alloc_tid();
> +
>  	if (scx_init_task_enabled) {
>  #ifdef CONFIG_EXT_SUB_SCHED
>  		struct scx_sched *sch = kargs->cset->dfl_cgrp->scx_sched;
> @@ -3717,9 +3769,13 @@ void scx_post_fork(struct task_struct *p
>  		}
>  	}
>  
> -	raw_spin_lock_irq(&scx_tasks_lock);
> -	list_add_tail(&p->scx.tasks_node, &scx_tasks);
> -	raw_spin_unlock_irq(&scx_tasks_lock);
> +	scoped_guard(raw_spinlock_irq, &scx_tasks_lock) {
> +		list_add_tail(&p->scx.tasks_node, &scx_tasks);
> +		if (scx_tid_to_task_enabled())
> +         rhashtable_lookup_insert_fast(&scx_tid_hash,

After reading the review from Sashiko [1], should we handle insertion
failures here?

	ret = rhashtable_lookup_insert_fast()
	if(unlikely(ret))
		scx_error(...)

> +						      &p->scx.tid_hash_node,
> +						      scx_tid_hash_params);
> +	}
>  
>  	percpu_up_read(&scx_fork_rwsem);
>  }

[...]
> +		/*
> +		 * Insert into the tid hash under scx_tasks_lock so we can't
> +		 * race sched_ext_dead() and leave a stale entry for an already
> +		 * exited task.
> +		 */
> +		if (scx_tid_to_task_enabled()) {
> +			guard(raw_spinlock_irq)(&scx_tasks_lock);
> +			if (!list_empty(&p->scx.tasks_node))
> +				rhashtable_lookup_insert_fast(&scx_tid_hash,

Same here, thanks.

> +							      &p->scx.tid_hash_node,
> +							      scx_tid_hash_params);
> +		}
> +
>  		put_task_struct(p);
>  	}

[1]: https://sashiko.dev/#/patchset/a19c8c74d7c767bc9865b75d6de7c723%40kernel.org

-- 
Cheers,
Cheng-Yang

