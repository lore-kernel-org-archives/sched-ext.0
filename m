Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794017722;
	b=5C2WE+Pj9F7VDz24NbxlpyRgIQu74WOaMcd/GS1C8sQ87ruX8r9r7SgbzC8VCImSQbRG
	 J6t03FDQjH2j/r+UkxyXVdYLKFFXPHEIILQdulwAh7nOZZIXOFAB6KjA/nOBOJLEwQWvh
	 uRtvDJ9aebIH3VF9p6tQI4bBEzCoV1sdVADGM0m7IHbBsdok7OEtJOa/BT0RpNjt2DyCN
	 QATdw22A57vuVAKzR4lpACjSX0mNCGiH/+n/GvdNXLjoGVDtdCVfsiP4Dic5+ba6g+jIL
	 U5IL+0rR9IUnHSeldE7B21VrzlAP/A3tJOFj5beedNdufSyVVpYudQVR6E0LC7fczxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794017722;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=STcyX3m8xxFaNUr4S3s1ec/7BuFxwi0Gt4EVxDhc2s0=;
	b=Tfbcwj3e2LxhxUNdAstLM+xSpqlbOPmXcMSK/blB4yLMdruNX8CE5BSMare0syK1Euz+
	 2pXOWSgJXXX72WBWGzeR/sGLev7Ca36M+doE1uk8fl343ZRewtUKZ9a5TJVRwLv8pVYZe
	 n7DCLETTplTCk5Oj735kqip03PsHiIMRqpq6okoCnAX7elzYIMqUYFDexda+mwmDgMa1X
	 +fwYMoEaKNKd+qC52/n33gSCfCpCsIfojT7YzyV6FOB4sRCiheEWcuuFq4nuRZUWXg9as
	 TuJ8Uu4Ngbi5R9JFxYNE/X8uWaPLUtpwNJ+msXZuyV/rvCBg8jzu7bxDQ3O5mHJnbuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gMX0Ip7T;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F079D606A32E
	for <sched-ext@lists.linux.dev>; Sat,  7 Nov 2026 02:15:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F079D606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gMX0Ip7T
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a3517554f7so12633005e9.2
        for <sched-ext@lists.linux.dev>; Fri, 06 Nov 2026 18:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794017720; x=1794622520; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=STcyX3m8xxFaNUr4S3s1ec/7BuFxwi0Gt4EVxDhc2s0=;
        b=gMX0Ip7TRaCVuJ1y7lSbvm5vN4DLN6ZrxCuZZaa/yy71UUN9xEO+B2RTb9Nx3Rn1Si
         I6+Rn2hk1PjFscQc4QAQ3gWGiTyeBqy6jtB6u2oO1N1BLMVDcDqIY0N866aM8oAIXJyR
         Gacns7XNHIva4wTLMMzbN+C3ughhlpCz8ByECnAGCd4ZyGhAz2XMMoHjmjCOpzaL/+ze
         bnDltRBbUby4LJaWxjLQsBQhcy9u2GNYyZXPd+bsIXelPjleI7Lga7/VsCLR/v8aTMuY
         CkFvf7XdCj9cLTG7aA47ddDu8f0CVorjTwxOpHG8gFpewVtIcxsGtGV+YwBO3e3H2nSM
         IZ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794017720; x=1794622520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=STcyX3m8xxFaNUr4S3s1ec/7BuFxwi0Gt4EVxDhc2s0=;
        b=k3Stg+LQoz350+eMTWotON688GZm7Q/75xL+IpQztNUD97ZUHJ/ro/dzx0HiVwl4X2
         i6ECLL06tFu4LjQQD5PHDeDMmHjqzn3Rn1H/z/fzzjtlh9jq8vouh0dayD+L7rJ7YWvv
         LMWYX9ILKGrPakKgKRnBTNVA582WryRTSoYQeuct39CWUznC6P38XIL+zZq1moy7GDtO
         fkwTnbm+PFezHdICeMT9Q8seHg3+pA+buNReK8W51tGIZvABLbsi0JSu1kfXCWK5yzmC
         +ZLDMwyB1L+N2jpkjoKMorO6l+50w96tEogNFjZerQA4N5hM6OF3o9BUUmDgmFCtIxvZ
         ok6g==
X-Forwarded-Encrypted: i=1; AL+hErG+kb40Kjy7VvE8eDSCVec5pjIeK5Q9/Yj7GDMZh2/bdxlVwvfZVE1j+lg3hny4YyyT5unr4+0CvVE=@lists.linux.dev
X-Gm-Message-State: APuU4Z91T6poSFdUCEP1e3iNNxvKoOOFqwpOWGK1vYX/KM1zn32yFa40
	mkC/lF8UIkxntPnmmp179Tr8GU0qJREys23aYuxyAKnO/Iv9UwZn7b3w
X-Gm-Gg: AYBFou0RJR8JBY+ZiSuILN31oslfPRnuzvxkSk2gwYvHud+LtG9aEG7kvuHS8uDgyIl
	anFwD1b/ai7e3a2rLcDS5VXqTDyZwZnEnV5aPMqGazCkrip8CvGwNotscwCvLUFQJ/No/7y9uKm
	IQMNWs0i7+/k3fBLvM1CRCVIVOY4R+gHLpvw/Rt5OtyMZcw9BwoZOq//bCJVYM3TAEommA6FD1B
	kxzuYd3MPQ1v/4wLyopLYND4W24uLEceMLQVALiW7T6W9RXczeEUDqNBXVQm+oPfNR6dEf1SM7Z
	OOP9ZxT8YNvKCCdiFQ4V0YWHhlOYh0p+c6yCEB1Q0GhxBjpoQsXNuRwP26ndKFHx7DSlJSdOLh+
	N8917lM9ks46AMf7LDLBEnGsGqr23ezcG417pqanDTWYNq3Lvc6Mjt7WdCQnRYXlvvpNZBgrTC5
	6s7tHb5RcRGKnYwlBybgsTsMY4h9oYDR5bQytcl17t6lpwtemV6DaJEJM6ejmjcG7EMG4vd5Lju
	DouvrAU9JGc+3g+nD+Bm8kbkHQgP7EjxOEvpkgq9LM7PqFEbwmyCGqfIVatDduSbJINa/CKMtg/
	3fX+o0Kfehyl3wNLk+3s7ODZI6yR7pR6oIorJfz9M1aHJqkgWNpCFroSEuntB/z0Vh+duJshv+0
	fFok=
X-Received: by 2002:a05:6000:4301:b0:492:b948:1576 with SMTP id ffacd0b85a97d-492b948165cmr7641858f8f.18.1794017720351;
        Fri, 06 Nov 2026 18:15:20 -0800 (PST)
Received: from localhost.localdomain ([86.124.84.219])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d7cc5f11sm6367449f8f.49.2026.11.06.18.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 18:15:19 -0800 (PST)
From: Radu Toader <radu.m.toader@gmail.com>
To: bot+bpf-ci@kernel.org
Cc: tj@kernel.org,
	peterz@infradead.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	bpf@vger.kernel.org
Subject: Re: [PATCH 1/2] sched_ext: Add scx_tickbug, a scheduler that holds a task on an idle CPU
Date: Sat,  7 Nov 2026 02:15:09 +0000
Message-ID: <20261107021509.968928-4-radu.m.toader@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <f043064ddbaa8d0c3bd479100993d6f157076ed25b1ab98b78c05bb2f1effae8@mail.kernel.org>
References: <20261106094343.174905-1-radu.m.toader@gmail.com> <20261106094343.174905-2-radu.m.toader@gmail.com> <f043064ddbaa8d0c3bd479100993d6f157076ed25b1ab98b78c05bb2f1effae8@mail.kernel.org>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All three are right. This patch is dropped from v2 at Tejun's request,
so none of it lands, but the fixes are worth recording for anyone who
takes the reproducer out of the archive.

The starvation is a real bug, not a theoretical one. tickbug_enqueue()
routed to the local DSQ only tasks with PF_KTHREAD and
nr_cpus_allowed == 1, so a user task pinned with taskset went to
SHARED_DSQ; task_allowed_on_cpu() then stops any other CPU from taking
it, and tickbug_dispatch() returns before
scx_bpf_dsq_move_to_local(SHARED_DSQ, 0) for as long as nr_held_now is
non-zero. With the hand-off you describe that is unbounded and ends at
the 5 s watchdog, which contradicts the commit message. Your suggested
fix is what I used: dispatch anything with nr_cpus_allowed == 1 to its
local DSQ. A task pinned to a subset of CPUs containing the target CPU
is still delayed by the length of one hold, which -H bounds; the comment
now says that rather than implying the case is covered.

The sleepable comment was wrong twice over, as you note: the op is
declared with BPF_STRUCT_OPS() and not BPF_STRUCT_OPS_SLEEPABLE() as
scx_qmap and scx_sdt do, and since 136deea435dc bpf_task_storage_get()
allocates with bpf_map_kmalloc_nolock() regardless. The comment is
dropped rather than the declaration changed, since nothing here needs to
sleep.

The README now says the scheduler reproduces the condition
tick_irq_exit() handles and can be used to check it, which also matches
the past tense the BPF header comment was already using.

Disclosure: this reply was written by Claude Opus 5 (Claude Code) and
sent on my behalf, in the same session as the patch; the patch changelog
carries the same note.
