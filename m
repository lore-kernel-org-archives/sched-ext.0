Received: from mta0.migadu.com (out-214.mta0.migadu.com [91.218.175.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064701D8E01
	for <sched-ext@lists.linux.dev>; Sat, 15 Aug 2026 03:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786764717; cv=none; b=QGBDofPU5wDPm6twQ5aqnoZDqIFUQMw1o4o5bNiDD/2TVvlaS6MFPg09P+won8ZXVbSvbsbO21iiPsHCTVHEboGdqij7LMI1j2mzU+vnwkSdVNsEkW+xuYLg9kZH1un66dSqcAGJjh8hYI79hwURwS2TOIiZ0qFYz2xNtN90JwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786764717; c=relaxed/simple;
	bh=1ASyJqk7YcVtN755/VCx/q3P97t/MNoATX3Lkx1H1MU=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jLSkWuUlwANqEYYWkcTq5E7H9QbS9HOzhfuugSkJiGVBCOMBydDQuNfEIryUX+a5LE7s8yKbW69gJxH4dQKC3vF5QFHmV5sCvliZA6T6L0HJVA42lVhRNbe4uDQ9jFhFjgBpLhiVzDWA4IERmhuV2IlowGc+pudLNgVKCh9dpHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ePpjvDRV; arc=none smtp.client-ip=91.218.175.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ePpjvDRV"
X-Envelope-To: sched-ext@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=1ASyJqk7YcVtN755/VCx/q3P97t/MNoATX3Lkx1H1MU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786764712; v=1; x=1787369512;
 b=ePpjvDRV5sB/dXqbOsDPQh0Shkp7v5GAWrCA+rXtZ3t9vfNnyY6bGqH/2qrssBRAQd1M7HMn
 5G++CiV1mwPQ1vPPRBRyNXvR7PFWWqAmR2BYRygI4Th0tAdO7W32zJyKRhpIHjPlf8A3DrIb7Jr
 Gg0jGc1KfcFgPnfm4tS5BCco=
X-Envelope-To: sched-ext@lists.linux.dev
Received: from [192.168.1.116] (111.162.215.50)
	by smtp.migadu.com with ESMTPS id d325686902de12c1;
	Sat, 15 Aug 2026 03:31:42 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <9b5da7b7-5cd9-4a01-9977-f40fb2e7e279@linux.dev>
Date: Sat, 15 Aug 2026 11:31:34 +0800
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: cui.tao@linux.dev, Tao Cui <cuitao@kylinos.cn>, void@manifault.com,
 arighi@nvidia.com, changwoo@igalia.com, sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: don't rehome a dead task in
 scx_cgroup_task_migrated
To: Tejun Heo <tj@kernel.org>
References: <20260811103122.357067-1-cui.tao@linux.dev>
 <71d1c173b538ca29d783232d89464d7a@kernel.org>
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <71d1c173b538ca29d783232d89464d7a@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

在 2026/8/15 03:04, Tejun Heo 写道:
> Hello,
> 
> On Tue, Aug 11, 2026 at 06:31:22PM +0800, Tao Cui wrote:
>> A task can exit between cgroup migration commit and the MIGRATED callback:
>> sched_ext_dead() marks it SCX_TASK_DEAD before cgroup_task_dead() removes it
>> from the migration list, so scx_cgroup_task_migrated() can pick up a dead
>> task and call scx_rehome_task(), which re-enables it and leaks the BPF
>> scheduler's per-task resources. The other scx_rehome_task() callers already
>> check for this; do the same here.
> 
> I don't think this window exists. SCX_TASK_DEAD is set only by
> sched_ext_dead() from finish_task_switch(), which a task reaches only
> after exit_signals(), and exit_signals() sets PF_EXITING inside
> cgroup_threadgroup_change_begin(). The MIGRATED notifiers run inside
> cgroup_migrate_execute() with the same rwsem write-held through
> cgroup_attach_lock(), so no task in the set can enter the exit path
> until the migration is done. Tasks which were already exiting are
> filtered out by the PF_EXITING test in cgroup_migrate_add_task().
> 
> The DEAD tests you referenced are in scx_task_iter walks which run
> without the threadgroup rwsem, where dying tasks can actually show up.
> 
> Did you try to reproduce the leak? When code review turns up a
> suspected bug, it's a good idea to reproduce it first to verify the
> assumptions before writing a fix.
> 
You're right, I missed that. 
I walked it again, a task past exit_signals() is filtered out by the PF_EXITING test in cgroup_migrate_add_task(), and a task mid-migration can't reach exit_signals() until the rwsem is dropped, so scx_cgroup_task_migrated() always sees a live task. The DEAD checks I pointed at are on task iteration paths without the rwsem, so they don't apply here.

I didn't try to reproduce the leak first. I will next time.

Please disregard this patch.Sorry for the noise.

Thanks,
Tao> Thanks.
> 
> --
> tejun

