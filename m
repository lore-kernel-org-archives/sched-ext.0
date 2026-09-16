Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73A7227BB9
	for <sched-ext@lists.linux.dev>; Wed, 16 Sep 2026 03:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789528921; cv=none; b=EDc50xX+0bkAQt+jgztpLdP8NH4h/F225zY3e3fx99DGISv3sItK1msjO57+t0EF+MbXgobhNKxowr38UwJJRNlfAW4dRSumz72GwmwChejKWUwfwnvnCTD72PCfX0V821bUud6yfefQN0hOtrk+FSxChXXFXea1Apm49zk/N/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789528921; c=relaxed/simple;
	bh=D3CLGNiwVCABHuas+SAZs7G8ZXekXIlZp9TTHLSjYHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YjVdW2ZS8RqhBKoabPA9AzPthcJJn9uuzsdsbwpYVmIqw4CiJtJ8RDOwXG+mtwmV1TNvw3znFH36sY2gp0zF7BqCoEeaZs8rhseEGtW3mlIb7TRwOtkJBYVHt0GEKpTgLtTvSrMGQCoWsEFpMbnm14MXzniTz3Qw4HMyY9yL/cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FKwD1pYk; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FKwD1pYk"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc4c08393b0so391505a12.0
        for <sched-ext@lists.linux.dev>; Tue, 15 Sep 2026 20:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789528919; x=1790133719; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f7E5IwM38XGhPSN8pkZyIhxO0i8q0d5y20DyNnAE64s=;
        b=FKwD1pYkV6llcjONZ9WzfFVcOlE2bFaBEfTTy3RWZgZxEmM2xfB73e9YUi0T78Ms7j
         rzduBSy8SJi1dBQH4svDffy4xeGxM2Xw60u/Ok5HsoR3MPi48pVIWamU7L++rwNyTtAK
         Br+QgmrJ723rDoNfHQPt+7lADAEp6cKXZ7Ir022l7s16jpU5uzUw+huX2mBlFdE5NS1G
         v5rUtGpDz96L3P18Rdcdoi4pH951hq+sm+Tkxj10kk0EdLypDWDG+0Mhe7zhTw3vD9Ep
         YxFdF4C0Ok4sz1zdJ/FZ0C4pbTFDG3KVrLijaw7/eryiKcFDaRlnJhsQnaF1jZiCAlpu
         OXTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789528919; x=1790133719;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=f7E5IwM38XGhPSN8pkZyIhxO0i8q0d5y20DyNnAE64s=;
        b=vxHDNCmOUsKQurMnYp19dvBhWuD7C7xEIv6LDxt4Prmpe0Ow/zCmstVjS1O9QqPr8n
         iHgvW0JUhEele32rdKaw8M6Z14To+eBnQxJC9Qe+zwBkK46BrShCKt2s7FZGvO9c5NjL
         HqhJtq3wovuY/WNCWXKGF7qTmsiYoLAUgt9DWxCul3ERpb4btYeApfAWqGs8bBdz96E0
         pGVDyOGfDAcbSdF00NaUSs0J7JNa+oCX7DcO9RQLxjKPjFvq+TVODUHosq8OIqlnaBFo
         mJct0MygtveJnEXYN0aD/V8K1w1JfsLh/bZNMtGHyJqlFWCDGDMDCPwDouznxQdeEkfS
         n5TQ==
X-Forwarded-Encrypted: i=1; AKwUvBxpIWhX6o+fBFyTuGYQRMZcq1IVfgvtYpUhgFVlpJ5kdOBrTPP6/xRWREszXh9PpF9DxslOme5nQfk=@lists.linux.dev
X-Gm-Message-State: AFuF++l9VouS/CexMXUetRkSsHh5mYiDWZmlAY6S6HEDApbh5loul0V7
	pzHoerBa8REBoA0L4z+hFvy0d5iJQ1vYhTh9cy35qBqFQuXMbFLNnNwwfYRBUA==
X-Gm-Gg: AYBFou201jaTZ9wxKKP7yJc0gB2PjoogJm4AhR3FrSeG9SxrjfcYp18IxKRD0eAiwMO
	sjd0zzmj2SyY9xEu3A6juIHJjBs7D8NSnGJ9i0dbbO1oypYoIt0ffm4IQQAqaw5zE+qUj6ng38x
	/Mi105NMc1lxd8STJnNPMI9UUyTXk+3VyKRwqAouOw66Yj6SZ9Qtx7wUowZj9pdPhu04nllG8Fs
	3fqiyt+1MsPLwjP0TTtCAMydbgSLVvY5Ke8e+MlVnPey4cYElKa9rIibxe0tDlpI408IQcbt8tp
	JWaM1xVQTW+UuYECxoDY1wopo6LbBzjFnygjDj+oCWewCBo/LM6HzPhS92O8XYcVZNVBkinay9z
	GNUsy7xRGs47lmx0+55j5F2gwXRbFaQAw8ro29ZTUL0rENzHY4AW2bpahmV7kWKxyM8IqcGy5Qn
	sJv8F6HFmCXCtYuvZC45rsOar+4opE8pqoauIP3lm0ByKafAFNmeAp8MERkEqCkP8DUSOlx6W3K
	aKeAPjtTes=
X-Received: by 2002:a17:90b:524d:b0:39d:eca2:5c81 with SMTP id 98e67ed59e1d1-39e1e2dea05mr2365276a91.8.1789528919112;
        Tue, 15 Sep 2026 20:21:59 -0700 (PDT)
Received: from osman.mioffice.cn ([43.224.245.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e1b9068c6sm1799310a91.1.2026.09.15.20.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 20:21:58 -0700 (PDT)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
X-Google-Original-From: Zhan Xusheng <zhanxusheng@xiaomi.com>
To: "Shubhang Kaushik (Ampere)" <sh@gentwo.org>
Cc: Zhan Xusheng <zhanxusheng@xiaomi.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Shubhang Kaushik <shubhang@os.amperecomputing.com>,
	Christoph Lameter <cl@gentwo.org>,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev
Subject: Re: [PATCH v3] sched: Restart fair hrtick after same-task repicks
Date: Wed, 16 Sep 2026 11:21:49 +0800
Message-ID: <20260916032150.487242-1-zhanxusheng@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915-sched-fair-hrtick-restart-v3-1-7517f388f0c8@gentwo.org>
References: <20260915-sched-fair-hrtick-restart-v3-1-7517f388f0c8@gentwo.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Sep 15, 2026 at 06:13:18PM -0700, Shubhang Kaushik (Ampere) wrote:
> Do not restart the DL hrtick for SNT_REPICK. put_prev_task_dl() is
> skipped for next == prev, so dl_se->runtime may be stale.

put_prev_task_fair() is skipped for next == prev too, so as written this
reason applies to fair as well.

What separates them is that rq->cfs.curr holds the task entity rather
than the root-level one, so pick_task_fair()'s update_curr_eevdf()
refreshes exactly the entity hrtick_start_fair() reads, group scheduling
or not.  pick_task_dl() has no counterpart.  update_deadline() then exits
with deadline > vruntime, which is what keeps the repick out of

	if ((s64)vdelta < 0) {
		if (task_current_donor(rq, p))
			resched_curr(rq);
		return;
	}

That branch arms nothing, and __schedule() clears TIF_NEED_RESCHED just
after pick_next_task(), so a repick reaching it would come out with no
preemption point at all, which is the state you are fixing.  Two lines in
the changelog, or a comment at the repick label, would stop that
invariant from being broken silently from three functions away.

> +enum snt_e {
> + SNT_NORMAL,
> + SNT_PICK,
> + SNT_REPICK,
> +};

Three values, six classes reading them, no comment.  SNT_REPICK explains
itself; NORMAL versus PICK does not.  At the call sites they mean
"through set_next_task()" and "the running task changed".

I checked the conversion with the compiler rather than by grepping:
reverting any one class to bool fails on the incompatible function
pointer, and rt, stop, fair, idle and deadline build W=1 clean.
ext/ext.c I could not compile, SCHED_CLASS_EXT wants DEBUG_INFO_BTF and
pahole is broken here.  first is unused in set_next_task_scx()'s body so
the rename is safe, but someone with BTF should build it.

Booted 4 CPUs, HRTICK on, four spinners under panic_on_warn=1: clean.  I
did not reproduce the latency numbers.

Reviewed-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
