Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2A82D8391
	for <sched-ext@lists.linux.dev>; Fri,  9 Oct 2026 05:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791525205; cv=none; b=Mn9/dfzLmD1i+ScIzi7usa35K5/ABIfooTcnNYuoi+EdHHdzo2S9cKHhitM7/S9aa/fdfN8+NRJaeplLaa9m3xYIMpAh6cMJ9eSWigzF9cXpiOAZc9JbYRvdCpPMMFcJRrWQJTwhhJDB9BSgbuYwg5hV5YakQ9lj8fi0/wD7hU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791525205; c=relaxed/simple;
	bh=Ban0n7745AzBI+q28L7dD9Gn9SbstwTnM2yds7GYTLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WufPhktXNCY/WoQqBzka0pGqjC1oRiJyYFMXXQD8Hjkn73X3VjvdW0RFe+X+6oIEb3AcA11PwbRVN6+n6CGWb2yrecRHIcb8KDPQDGRvEekPsYpZ0ZiEenJbYU4DyMIiBYOFTNIUoHpMAxI+G775vvneFNwiN3NQjCMIdtBpEZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h7/Wjofi; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h7/Wjofi"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-48b06f58380so206735f8f.1
        for <sched-ext@lists.linux.dev>; Thu, 08 Oct 2026 22:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791525202; x=1792130002; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wVlDnOJmdRHsN4qn4A2HDhzFDxkd+SqZNh2m1iwQaYA=;
        b=h7/WjofihOeIIgwIFRpzxFJgr5Yu85jovWGt6Uv6hPpbqn8wj6WbRigzEsUV6HG+Sn
         IlZoPWLM9m0rJ2/NSh1JxJH7VAQlLRLBf4q6SWMrva3W28xwqzCOxzFR4uMIp5guL7ZD
         QZOSbL5xYkK1qRiH31zqqMZp6tmlkYmEcJ577Prx/Az5xrqxWgBJm5qCMIllOTr3m6ie
         58RgX+kSxFu+9oAlCmUVgbcLAfhaJB0kaXQUhXCbo/z1XL8I6WD5VNt1xEo7BN8sZjSR
         8wVNpnT2o6l/Jc7you9uhUXA557+JSF5O8LxC8PT8KbVUxdDMNilnTke3lZJpGpzkQPj
         +cuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791525202; x=1792130002;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wVlDnOJmdRHsN4qn4A2HDhzFDxkd+SqZNh2m1iwQaYA=;
        b=p6X+BXnRSyQyskqCTRyKT7vQ52bXQCQSkbXvsISx0AkuhYr0HO2z4h9hAjAKZAAJ3G
         +bqE7QIGlNxWgFIBHKYDthUsGTsFC9hsGo6k0Z1Fo7zH9CnGi3KPLb0fjyoTGW67FWxK
         LojXuBC+gtWDH8ElSF2Z96JufQw4gxPCEQc1cCx0DOqSL/YnRBNjpPTtJLl0XhxCM38A
         MPSXBAg0V+3vyd67iDRx+BnR3jx0dL4xpISAkkA+VIN30oYvAYqMeNOBfW+RFKLsZXDv
         BVbE3MZM2On4L6D9xyVNUnb9qVf2whl1Do0NKmBHZNHEO0WwLZummJv5+VBmyO0kxO21
         NZ5Q==
X-Forwarded-Encrypted: i=1; AKwUvBwr+rmx72ffpT0KNXCkfX9JvW8g+XARFdEwAyXjp75bQu86uFBxHHDjmT2njVnXACfCuQdmRMvhshM=@lists.linux.dev
X-Gm-Message-State: AFuF++lMIm9MZjntuJRjLn+61Q6Mo7vvL/g3Z8if8cMlZs3xPz1RIbzW
	y4VDPO0pqv7gGPaGBYhRX4TGuJuuyep6TsUTLbIVucrRc0ZeXOfjnSpd
X-Gm-Gg: AYBFou3qLqE8s2EC8Lb4IMlWqgel7jiVzsQBlIt71veclFRyfq4POI5HdnlcB1np1Ec
	QM1qzXgrl8C5fzGFweeghZppSs+akMWfH3RRcCOVnC88quPInR/sLp54yFL8LvLKbDWl3RTkrpE
	AgLoQtaCBPOtO3TlMmYxVHKNj0RFJlwYGtEMhFqUnTReUh3deOj0lVtKx7tuDVFFLleVez6Nc4w
	Bm4ouUHHj/lbUusquB0KQy8xJsVPfWqrX5m8X0D4WfzgALDREMQ42i8jjrvju38jVg/bmovmSLD
	ht754e3WLuU6TzornqnMKxIRNuMJ7R3YnSjPNcZud665I0noBnbZ6qgc5OkoSDkuBTsS3wCS8Z2
	Dva2TOr4jqeDpMrQafiRi5hWXrn/BiCuQ8cbt1mjbNCGCZWWeUuYw9XS75WnSygS/2r/1+vrluJ
	O+aj+cWKWe5lcPsSRl7BN6YDvEJbuFRZY3nADKTI0lPt2++3DBwOCwabEDXoDTz8+Lb2xlVPPNO
	I1lnsF7Gc6KIspVVgPl
X-Received: by 2002:a05:600c:1912:b0:4a0:73b:a222 with SMTP id 5b1f17b1804b1-4a18e3ee97dmr11594485e9.0.1791525202556;
        Thu, 08 Oct 2026 22:53:22 -0700 (PDT)
Received: from lima-kdev.local ([85.100.66.184])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18ca51465sm22826485e9.4.2026.10.08.22.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 22:53:22 -0700 (PDT)
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
Date: Fri,  9 Oct 2026 08:53:17 +0300
Message-ID: <20261009055318.29609-1-kayracizmeci@gmail.com>
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

>  	task_tick_cache(rq, curr);
>  
> -	update_misfit_status(curr, rq);
> -	check_update_overutilized_status(task_rq(curr));
> +	if (!tick_pushable_task(curr, rq, rf)) {
> + 		update_misfit_status(curr, rq);
> +		check_update_overutilized_status(task_rq(curr));
> +	}
>  
>  	task_tick_core(rq, curr);
>  }

Hm.

I think this mechanism added on here does not works.

Before fair_check_pushable_task() is called, we check
if nr_running is bigger than 1. If it is we return false.
So when we enter fair_check_pushable_task(), nr_running is
equal or smaller than 1. We first run __check_pushable_fair_task()
but it doesn't really matters, since it's output
can only return false. Next block is skipped to since
next == NULL. When we're at the check_pushable_short_task(),
the h_nr_runnable check is always true on this path,
so we return false.

It this intentional? Or am I missing something?

Thanks,
Kayra

