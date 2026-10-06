Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD851448E0
	for <sched-ext@lists.linux.dev>; Tue,  6 Oct 2026 19:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791314661; cv=none; b=ZYj615uKr+HVW1juHiDW2KThKm570Hc9LH7dqkFomWY00gzJIngkaNrUPW54VozDXw2lQWVXJ1txvfTz7tIDmqwlrVfKvyzCR4Mts1feSJGx6XJ7G918IyQH3/1Exsd+cgBCPqiiCL9OS+pE6CXldebNpppR5WoI7ED9J8iW91I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791314661; c=relaxed/simple;
	bh=Kt8YNEWfbwDWsI+SQanVP9qIuuvXMzBnWOpvIaiQncQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PlkPSWaINg/r+G+kPgS/opBv1PuJkAanITc9ahv2LW+Lcy45eFgfudqzlEoOrk/23SXGkqI/L/HFWLG6VXj+qYovXJYMwo1Iu1s7sDDMpHNbc0f1s6KwFXfImRtyHobPs3k20EVnLweVzSW4ZhkpYYuApavxYztjXRGj9mMd8o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sCiboYTP; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sCiboYTP"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-4a17586f8d5so1513125e9.1
        for <sched-ext@lists.linux.dev>; Tue, 06 Oct 2026 12:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791314658; x=1791919458; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Yx7UFENNd+zDz7Za9PxYYzlJTn11JexZcpPUkJvIP5A=;
        b=sCiboYTPw96NEyRZFQfjcPDmz4bF5NZ0r5deBNK5RToXv3nqaV+qWcFjAOcd8gN+Ca
         pZLfuhPd9jzTy/xUqDEwR7wghxiOs7whJb2sgWhMScPsX2wwCZXZ+O4frlHLFI4Aa0GL
         zizwsi4kCdYSCBmoJSRPRXrCO6whSy4XehV2KKwCHJxCfOF6A+NO6XZfDgRqMoE/Q7Ia
         L5GB9VCGxc+2cUVYF8R3iCOPFx8W3Ob4vaSbjRRc4jHi1KvRFlmfBlVeIcUUY+GJsap9
         3jre7TSRNPzL+Ndu9K8zYUQZsSJMQ1+h6InI5Yf+Fo4Xx9Ys3N/Pjqi/zKFaOzXTA0hw
         nMpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791314658; x=1791919458;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Yx7UFENNd+zDz7Za9PxYYzlJTn11JexZcpPUkJvIP5A=;
        b=vAQcN+byIbci5xvwr/pRMdC6Hb+juzH5bKLM6USmomzx5CO4WmO/MdXp1EhQ0m1e0v
         hYnj9dcFWLWgn/RoJTSSUaLjqf+B+WBgJ7iJC56sTeXjeumuGXM4bsXNvTDw6hHa1Ro9
         fhj5ITSJCQ3LYjHCQoSG1v0AD1QlCA6q07vvwbjBUZ6W80PMiYsUZzjT2E3Mqb5p1dd1
         a124JHrcLJVfwH3G/MlIRG5fSeV8oKf+IU8LV7l9NZR026+P+Kj4Oe9fLVHawk2/nd9Q
         oPtQFOugzEEKv7p37ek/nOvDECDcFxWy32+O692pKknL11iCUXSCL3kUVYvcpTL5ixSB
         KJIg==
X-Forwarded-Encrypted: i=1; AKwUvBzBlY+/0qikJz9JkXz0N5pLt4RFjKZHwLJV9OSGyRN3wakXNmLAxhamy1oedAgDIquqzRgoyWvDDPE=@lists.linux.dev
X-Gm-Message-State: AFuF++nU6Snj0OXZgVlkXuST6iLHcA5vxN9l1HKCWcB2VcGilNkbAs9F
	Q/LPbQd2b51CQp4uJZ+S7v363RWB/Q9FyBkjcxgvCSPiwJVD0mX3Q+pg
X-Gm-Gg: AYBFou17I0Z9fnZBlTdBM4isvAHuOkE8ytAULbnLUs3AXxzOk2KFGFPXS6FoIjcFlRX
	Xa9d+u323mB4PR6TGqda2Fs50qursVDNrRXvjZVZoWd5eSm3/YE4vlvPAqrXoPYpJLJhmOZn2TC
	CYVM8qZ9LYYcDOyKfImeR7E1kKwV7W+GGVSAHksReyWlG6v3CUHY4W3K1NwczT4mpgJDV52K9ex
	hCzzwnj5R8/YJXCQDD04N3O1BrFdh8ejhxhMdbOLjUP4Ck4dT7hLLi/+PXWYvhlV5bejNfcJh/o
	71rWkpul8RHlODE0m4CltcLLgK6YpyNcyKl2JsUinK+jiyS/TwKHWOYudstruLnZkZdALBSQPXU
	hUP349HT5UpEjT6rPWDrueisp9Rmj/RuD/D6PLwjGb8Q8EH4EFzOsxJyePoPzLLecajmMerSmjq
	lRnwVaXn2D3hW/KPDGORx5uxqmtoFhFhdHg+qqhadsMzmtlu5Ba9AtlW6xeABYbePsBrbchFkvl
	oZIhf3UgAmr+4UMNSvho4BN6X7UY8c=
X-Received: by 2002:a05:600c:46d5:b0:4a0:1ca8:70e2 with SMTP id 5b1f17b1804b1-4a02751fa7fmr252725835e9.1.1791314658282;
        Tue, 06 Oct 2026 12:24:18 -0700 (PDT)
Received: from lima-kdev.local ([85.100.66.184])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a17f54a5cesm6315185e9.5.2026.10.06.12.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 12:24:17 -0700 (PDT)
From: Kayra Cizmeci <kayracizmeci@gmail.com>
To: vincent.guittot@linaro.org
Cc: arighi@nvidia.com,
	bsegall@google.com,
	changwoo@igalia.com,
	christian.loehle@arm.com,
	dietmar.eggemann@arm.com,
	juri.lelli@redhat.com,
	kprateek.nayak@amd.com,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	lukasz.luba@arm.com,
	mgorman@suse.de,
	mingo@redhat.com,
	peterz@infradead.org,
	pierre.gondois@arm.com,
	qyousef@layalina.io,
	rafael@kernel.org,
	rostedt@goodmis.org,
	sched-ext@lists.linux.dev,
	sshegde@linux.ibm.com,
	tj@kernel.org,
	void@manifault.com,
	vschneid@redhat.com
Subject: Re: [PATCH 10/18 v2] sched/fair: Add force push task mechanism for fair
Date: Tue,  6 Oct 2026 22:24:14 +0300
Message-ID: <20261006192414.7308-1-kayracizmeci@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261002154415.2270586-11-vincent.guittot@linaro.org>
References: <20261002154415.2270586-11-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> When the task is alone on the CPU, it's never put back in the enqueued
> list; In this special case, we use the tick to run the check used to push
> runnable task on a btter CPU.

I love typos. Like, in here. 'btter'. I think it should be bitter. Like:
"In this special case, we use the tick to run the check used to push runnable task on a bitter
CPU."
(Or maybe by a really low chance, it could be 'better' too. Maybe tho... :>)

> +static int active_load_balance_cpu_stop(void *data);
> +
> +/*
> + * See if the alone task running on the CPU should migrate on a better than
> + * the local one.
> + */
> +static inline bool tick_pushable_task(struct task_struct *p, struct rq *rq, struct rq_flags *rf)
> +{
> +	int new_cpu, cpu = cpu_of(rq);
> +
> +	if (!sched_push_task_enabled())
> +		return false;
> +
> +	if (!rf)
> +		return false;
> + 
> +	if (WARN_ON(!p))
> +		return false;
> +
> +	if (WARN_ON(!task_current(rq, p)))
> +		return false;
> +

OK. So, this is called from task_tick_fair() and task_tick_fair() is
called from sched_tick() with rq->donor. So on Proxy bla bla
this could get true. Or maybe I'm missing something. Dunno.

NOTE: Some more places could have the same case. Again, dunno.

I need more tea. And sleep for not having to drink that much tea.

Thanks,
Kayra :>
