Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.136
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795008363;
	b=R8B8/Qhv2xyllEzJmuh1UIAem67DhB+izzWFpDOMKIWsIUdIMsIyVOxVeLnowKMH42Mf
	 rEEPQLlrzGDFE1ZpnzbHuyrND6wSCjTTiBFP/+qKrVRpahmec5vZcWg0o954A8C3dil56
	 C0m6sP45bhWNhOedl4q/JQbyj8d0niE53FA1UIrsezHBd3Tohr0f03JDlESvxUkk4CssV
	 TjzNuFO8qfhMkxp6Fi5kKqdcgJACS0V7N06eUax9LB0AWS3vkWpLX8WFQ+iiC2RvPNxZy
	 /E3nZHjW8XEAiQ4NKlvkjC1esSVxqnHdDF7AMzuJlAhNnt2A+QqLXEL6i01IJNB9s1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795008363;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Cc:Subject:To:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=nTxoScPK+PaRXauFch0tTuVGwOPEhY/Ag42egEIJ0uY=;
	b=izfOTVFpHso9MhJp0tpp/9SYHmVM5zMI38uZlR/dZtOhHkxQubWgg1fozdVv78XLzJtd
	 gm05rXu8EVDOTjW2hDoUtO7xcmnhy6TTfAHveGcQZY77IqbtqfmnkFJh+1bR1jMxRV6wH
	 J203hNojWYbajS9PZcXPa8OoRahJtfAEkITpxOVx+fgrIK2Kr1tkBGrp3wD6aqLZXDX+d
	 EgGlgUyERp/lcL15epw49g5mb1igi/Puea+8RY2mBwH7YxgLspo2bJ+d+DsLOmjG0gcSf
	 vn5/ZOY5J0dXJZYNZs0esTskbgVqaYrrA5eJx0qC0jLTZ/rBoES2olxX8t3MbcDIZlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=YLTxS9Yo;
	arc=none smtp.remote-ip=91.218.175.136
Received: from mta0.migadu.com (out-136.mta0.migadu.com [91.218.175.136])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A2F606A31C
	for <sched-ext@lists.linux.dev>; Wed, 18 Nov 2026 13:26:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8A2F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=YLTxS9Yo
X-Envelope-To: sched-ext@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=j4hyvkpO0ykBnvTe0xuElkbIVVm/NwfBxx0mBlzXPi0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795008358; v=1; x=1795613158;
 b=YLTxS9Yor2lz4H+zz37Xjo1mArFQ/J/liMC5scXP1YCK5HNibwczqGyTTJ3qZLFPBA1PsCxr
 Q6H5SyfH4G3gW/UBHOmNVlM6dNwF8FDkOO3dIWXVucEa3KMN2vH+mUXrsddxReMknmKBTviZaia
 Pm0hTsbdafHUvPZxG1dfnsGo=
X-Envelope-To: sched-ext@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 317c6210a24ea451;
	Wed, 18 Nov 2026 13:25:58 +0000
X-Mizu-Trace-ID: 317c6210a24ea451
X-Migadu-Flow: FLOW_OUT
Message-ID: <11f7d4ff-b3f1-4d8c-a37c-887d354596da@linux.dev>
Date: Wed, 18 Nov 2026 21:25:44 +0800
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: cui.tao@linux.dev, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.4-fixes] sched_ext: Don't route tasks to
 SCX before __scx_enabled is fully patched
To: Kuba Piecuch <jpiecuch@google.com>, Tejun Heo <tj@kernel.org>,
 David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>
References: <20261118102453.1315267-1-jpiecuch@google.com>
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <20261118102453.1315267-1-jpiecuch@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello, Kuba,

在 2026/11/18 18:24, Kuba Piecuch 写道:
> scx_root_enable_workfn() sets scx_switching_all and calls
> static_branch_enable(&__scx_enabled) before switching tasks, and
> task_should_scx() gates only on scx_enabled(). static_branch_enable()
> patches jump-label sites in address order rather than atomically:
> task_should_scx() may be patched before __schedule().
> 
> If a concurrent fork or sched_setscheduler() runs in that window,
> task_should_scx() observes scx_enabled() and moves the running task
> from fair_sched_class to ext_sched_class, setting need_resched on the
> class degradation. The following __schedule() can still observe
> !scx_enabled() in next_active_class(), skip ext_sched_class, and pick
> rq->idle while the runnable SCX task is still rq->donor:
> 
>   WARNING: kernel/sched/ext/ext.c:3840 at put_prev_task_scx+0x405/0x7a0
>   Sched_ext: enq_select_cpu (enabling+all), task: runnable_at=+0ms
>   Call Trace:
>    __schedule+0x5cc/0x1100
>    preempt_schedule_common+0x12/0x40
>    preempt_schedule_thunk+0x16/0x40
>    __sched_setscheduler+0x8d8/0x920
> 
> Gate task_should_scx() on a scx_task_switch_enabled flag that is set with
> release semantics only after static_branch_enable(&__scx_enabled) has
> finished patching all call sites and scx_switching_all is updated, and
> cleared on disable alongside scx_switching_all.
> 
> This bug was found and the patch was written with the help of an AI
> coding assistant.
> 
> Fixes: f0e1a0643a59 ("sched_ext: Implement BPF extensible scheduler class")
> Cc: stable@vger.kernel.org # v6.12+
> Signed-off-by: Kuba Piecuch <jpiecuch@google.com>

The release/acquire gate looks right on both the
enable and disable paths.

Applied on top of 700a332c3fe3 (for-7.4-fixes HEAD) and ran 25
scx_simple load/unload cycles in qemu under a fork and
sched_setscheduler() storm. The baseline hit the reported warning on
its own 14s into the run, log below. The patched kernel went through
the identical run with zero warnings.

[   14.225125] CYCLE-7-start
[   14.352153] ------------[ cut here ]------------
[   14.352157] WARNING: kernel/sched/ext/ext.c:3840 at put_prev_task_scx+0x4e4/0x750, CPU#2: storm/91
[   14.354627] Sched_ext: simple (enabling+all), task: runnable_at=+0ms
[   14.372849] Call Trace:
[   14.373019]  <TASK>
[   14.373164]  __schedule+0x52d/0xe60
[   14.373395]  ? bpf__sched_ext_ops_running+0x62/0xac
[   14.373709]  preempt_schedule_common+0x12/0x40
[   14.380061]  preempt_schedule_thunk+0x16/0x40
[   14.380628]  __sched_setscheduler+0x815/0x8a0
[   14.380918]  do_sched_setscheduler+0x154/0x1f0
[   14.381220]  __x64_sys_sched_setscheduler+0x1c/0x40

Tested-by: Tao Cui <cuitao@kylinos.cn>
Reviewed-by: Tao Cui <cuitao@kylinos.cn>
