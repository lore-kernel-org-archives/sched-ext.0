Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D232A42A152
	for <sched-ext@lists.linux.dev>; Fri,  9 Oct 2026 06:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791527508; cv=none; b=jG/C62aFNAVIBDCiTCwNlhEB5zO66Dmvzpnb/szJkO56MMS++7ZSxTCtmgVORYneJV0MgY678oX7YDDGWpgO1xz60QGDhWjSROCpBzZDyye1BoZsJZMXOiWyGxajnVa3xqp1ElzSg580o6hqItUqsln/tm9TNUc8y8RN/vgdvHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791527508; c=relaxed/simple;
	bh=G8p969TSPt4pRVkrqnzxS3mmH3ELFFspsjEpF+ZfLvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WZipEzYgDal9mfM6WCFZ5DbElbT7dbwNAEy5y391gbolYdmSnt68qiJ152aHZ49NbUyuTWl3aVn5vMJ92IHRVA/aNvVGXv61mSJiKHxezcr37HX+l/HGBfeIfbeZCGXhc0RRWBm9lejbVVKTN01BPYZfM7wZGWPxqk9Zbre5x/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sw33FHvX; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sw33FHvX"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-49e6b771d06so4457725e9.2
        for <sched-ext@lists.linux.dev>; Thu, 08 Oct 2026 23:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791527505; x=1792132305; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/prsEyltlekkl/5pKA40pBQXK0nwU4kVOsJT37viE/Y=;
        b=Sw33FHvXY7v6rHKfxhPGndVaA51a6/IessBTDC8EOrEUVPERVNxCjuPltZgL+uGAe8
         LPHDITXA4zSa0EIUce9lH6vL+o8yaHnatYxiTaXqhsmjN+nYvxrwu6ekop2tN/eV3zSj
         nPoqmU1mTdSvmsNnyjqWPjGhYqGPMhy2tMMr7WNO1n4KL7DP+n+X5hYF2G8qnQBDsMSn
         DvGRCcrM014TkD0HdThe3mWtD9pub1Eg3f8c4jVM5qVqZxNF1wJFvGfE8CwOkYMStv7Z
         RrCd37hdtRjIZppJD5shd5uu857bj8bDhkoY4kaqKZF16GHRRSL+fjYN+NJP7iJLL1uy
         wMhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791527505; x=1792132305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/prsEyltlekkl/5pKA40pBQXK0nwU4kVOsJT37viE/Y=;
        b=D0Hm0qNaKgPO605r7I1FteGBd6l6mjdsHCylbON0UC2qY2XSWcdLDt1X/tTss/sm5G
         d+DTJPi1JD44/GoeD0UUpsnhN78wfKmb120TmrVQ4WyjhbfhmKPcvQ4/ajhGn5k/zC5P
         9Xf1CPp8sKAzZJOb3m3PWUl8NuUbGp/TnOm4if73XmRkwzJclsYAbLP5GYQLmxpL7m78
         ZSgld1GHC7hNvOlnsTIBzb7y4FT/ChvfPOZYloLkkDns/iJnv50dFHRHvwU+4TWReHyA
         tKoy2uMMo6v8Mfjls/Sh7Tdyyb6mMvHAR/b8rr83qzbUMRu985SKdvGwQWYEh/LrwFz1
         Sv0A==
X-Forwarded-Encrypted: i=1; AKwUvBzQe2dxZ3+NuCcTmohyaMOBe87nXThGNo1j2tURSVzGkCQUzWzwdJpI9NEEA2sQ9XMKoCFnN6Fyz8s=@lists.linux.dev
X-Gm-Message-State: AFuF++lzJ4h0g4Z6oqljtQcicYwyKZyYPWlrNVR6rlaeR/d+afwgHyVu
	xruoBPHtqb+nxHeU6fo0V0tZo2Hod5osNpoCXn0aFTX2mhb4PrKfai3M
X-Gm-Gg: AYBFou2tEPT6JxGQ2U0j6E5qgw34seUSI7KjCQC/XFdcH1FiT4kgLSrTVbqtVUJeZ1E
	MtxMbQ1FCDUnHC03u6CVSP/c1LJb07Xg22SazFzZuBFarvpN0K4Jb7vz/iIKPGlRg0+hEeIIaA/
	EHCJM7fsDKKAVIt8KfMuHUg360AMwAqL08KZZuLO3z0QSkhck7tcdX8m7xYxmt2RVoFl7ncxlbw
	mBdM39w2gRJ+0+DgkM/ch2Ab1Hjy+KfBIISh90oYWkJWXZQkNuAhmAkXvztO2ZHj6byCm5F6zn7
	hsIFpHqnNxcvSdV4cTA78HNHdT8kTaSh8pszHm2xCTRE6YS1jS2uuxRzIJDyehP7+Pa+AMVPLuU
	X9KKP2l23FHfZITFNb8Tbkc1C16z7rC9UM+yIC8zeGzezcEOLdCfsopa/9gjjsXGJaMF6gOyIIV
	/cGtJzaN7Rw+LdElqwTy0SEIk6LoZyCquUwzn0BYcfdVXRfgrOa5aDUoZL7tCFJ8kRYNvyOAVlM
	9szzzeWWbzUMp32mCgp
X-Received: by 2002:a05:600c:a086:b0:4a0:1f9e:5f78 with SMTP id 5b1f17b1804b1-4a18e3ea887mr14032945e9.0.1791527504788;
        Thu, 08 Oct 2026 23:31:44 -0700 (PDT)
Received: from lima-kdev.local ([85.100.66.184])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18bf0abcesm39170955e9.1.2026.10.08.23.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 23:31:44 -0700 (PDT)
From: Kayra Cizmeci <kayracizmeci@gmail.com>
To: tim.c.chen@linux.intel.com
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
	vincent.guittot@linaro.org,
	void@manifault.com,
	vschneid@redhat.com
Subject: Re: [PATCH 18/18 v2] sched/fair: Take into account slice in EAS
Date: Fri,  9 Oct 2026 09:31:40 +0300
Message-ID: <20261009063140.30016-1-kayracizmeci@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <179bcb50be21f834423f9b5c068b5fce4cb65871.camel@linux.intel.com>
References: <179bcb50be21f834423f9b5c068b5fce4cb65871.camel@linux.intel.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Tim,

>                             struct task_struct *p)
>  {
>         unsigned long task_slice = p->se.slice;
> +       bool target_first = task_slice < get_rq_min_slice(cpu_rq(target->cpu));
> +       bool min_first = task_slice < get_rq_min_slice(cpu_rq(min->cpu));
>
> -       /*  Select the one where you can run first */
> -        if (task_slice < get_rq_min_slice(cpu_rq(target->cpu)) &&
> -           task_slice >= get_rq_min_slice(cpu_rq(min->cpu)))
> -               return true;
> +       /*
> +        * Select the one where you can run first. Check both ways, or the
> +        * result depends on the order of the CPUs in the PD.
> +        */
> +       if (target_first != min_first)
> +               return target_first;
>
>        /* Favor previous CPU */
>        if (target->cpu == prev)

> Take an idle CPU X and a busy prev_cpu. Any task can
> run first on X, because an empty rq has min_slice == ULONG_MAX:

> - prev_cpu scanned first: when X is the target, the slice check
>   selects X.
> - X scanned first: when prev_cpu is the target, the slice check fails,
>   and "Favor previous CPU" then selects prev_cpu.

> In the second case the task is stacked on the busy prev_cpu even though
> it may not run first there.

Agreed. 

But ULONG_MAX doesn't always means that the rq is empty.
(See my 18/4 review, maybe I'm getting something wrong)

Also, I assume prev == min-cpu.

Scene:

target is X, min is prev, prev has a 5 ms sliced task while X is empty and task_slice = 4
target_first comes true and min_first comes true they're equal and min is chosen.

If however, the task_slice was bigger or equal to 5, as correctly target would be chosen.

LGTM atleast. Eh. (ULONG_MAX could be a problem tho.)

Thanks, 
Kayra
