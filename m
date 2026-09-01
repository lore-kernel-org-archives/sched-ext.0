Received: from mta1.migadu.com (out-114.mta1.migadu.com [95.215.58.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12BF733F368
	for <sched-ext@lists.linux.dev>; Tue,  1 Sep 2026 12:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788266141; cv=none; b=eHBFJPioD3RtKB9Zttd7+r/BRvbU0Ks9LHDxlv939OkJ4MEFRTUjmE7evtaQKm4mB9rJdbmkRpX15vfOihbVeTXBqXau3aMgKtbbyZNMIgveZF3zb07oqj/WdxiKwSQBnvXpkcFsRBZly+T6EaBqJeXWHWec43pkuJqAMcX0Usc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788266141; c=relaxed/simple;
	bh=X+DkHxLt+CgQ947vh/gRAc51B7xguiauK38xqdvZxys=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=cHxRMLEmcExDQCmdf+IjxQBE7xQ0iV7vu/WA74DmX3udF9QWzHGAkr/exd0zbNwjQSJjpP/W01B0DQw4r4vFpauZOUPRuxJTKDty9SWfDJ7+whbqQjSwOo9gOPOjdmfAuDSPiJ3nrClbyE+gZz2tNXhvtNKHS6pvDSEEG29+zWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TO6oWUUI; arc=none smtp.client-ip=95.215.58.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TO6oWUUI"
X-Envelope-To: sched-ext@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=X+DkHxLt+CgQ947vh/gRAc51B7xguiauK38xqdvZxys=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788266136; v=1; x=1788870936;
 b=TO6oWUUI09uwb/YfZGHXMwEYOIzjKFgi62j8uJF0gck0b2+dF4synoWsWXs23Q+M989L6zLK
 E4z7+5b8lFl973Tx4oDm98TYi9UxTG1zP2ObCCaSiwlCOG4z2N+zXN3YGI7+sfRxjguKui89MXk
 hFhQfQaGJ4XpqNGVv8IJ8gDw=
X-Envelope-To: sched-ext@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 6fb685d0476b67ce;
	Tue, 01 Sep 2026 12:35:26 +0000
X-Mizu-Trace-ID: 6fb685d0476b67ce
X-Migadu-Flow: FLOW_OUT
Message-ID: <2da859e8-2025-4926-99f4-8ba595e25abf@linux.dev>
Date: Tue, 1 Sep 2026 20:35:22 +0800
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: cui.tao@linux.dev, tj@kernel.org, void@manifault.com,
 changwoo@igalia.com, michalblk@google.com, sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 Tao Cui <cuitao@kylinos.cn>
Subject: Re: [PATCH] sched_ext: don't deliver duplicate ops.cgroup_set_idle()
 for same value
To: Andrea Righi <arighi@nvidia.com>
References: <20260901031101.731943-1-cui.tao@linux.dev>
 <apZ-B__OiVcZW46Z@gpd4>
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <apZ-B__OiVcZW46Z@gpd4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Andrea,

在 2026/9/1 15:25, Andrea Righi 写道:
> Hi Tao,
> 
> On Tue, Sep 01, 2026 at 11:11:01AM +0800, Tao Cui wrote:
>> From: Tao Cui <cuitao@kylinos.cn>
>>
>> ops.cgroup_set_idle() is documented to be invoked when a cgroup
>> transitions between idle and non-idle states, and scx_group_set_weight()
>> already skips value-preserving writes. scx_group_set_idle() delivers
>> every write unconditionally, so rewriting an already-correct cpu.idle
>> value feeds the BPF scheduler a transition callback each time, which
>> toggle- or accounting-based schedulers miscount. Mirror the weight
>> guard and only deliver on an actual change.
>>
>> Verified with a probe scheduler printing each callback: rewriting
>> cpu.idle=1 twice on an already-idle cgroup delivered two callbacks
>> before and none after.
>>
>> Fixes: 347ed2d566da ("sched/ext: Implement cgroup_set_idle() callback")
>> Link: https://lore.kernel.org/r/b53c61a1-4d7d-4232-941f-d48b0563d4ed
> 
> This link seems broken, I think the right one is:
> 
> Link: https://lore.kernel.org/r/b53c61a1-4d7d-4232-941f-d48b0563d4ed@linux.dev
> 

Thanks! Somehow my vim seems to have eaten the `@linux.dev` part of the Message-ID. I'll fix the Link tag in the next revision.

Thanks for the review!

Best,
Tao

>> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
> 
> Other than that looks good to me.
> 
> Reviewed-by: Andrea Righi <arighi@nvidia.com>
> 
> Thanks,
> -Andrea
> 
>> ---
>>  kernel/sched/ext/ext.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
>> index 8041c87a3562..8b3625107b72 100644
>> --- a/kernel/sched/ext/ext.c
>> +++ b/kernel/sched/ext/ext.c
>> @@ -4933,7 +4933,8 @@ void scx_group_set_idle(struct task_group *tg, bool idle)
>>  	percpu_down_read(&scx_cgroup_ops_rwsem);
>>  	sch = scx_tg_knob_sched(tg);
>>  
>> -	if (scx_cgroup_enabled && sch && SCX_HAS_OP(sch, cgroup_set_idle))
>> +	if (scx_cgroup_enabled && sch && SCX_HAS_OP(sch, cgroup_set_idle) &&
>> +	    tg->scx.sched_idle != idle)
>>  		SCX_CALL_OP(sch, cgroup_set_idle, NULL, tg_cgrp(tg), idle);
>>  
>>  	/* Update the task group's idle state */
>> -- 
>> 2.43.0
>>

