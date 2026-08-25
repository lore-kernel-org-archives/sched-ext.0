Received: from mta1.migadu.com (out-23.mta1.migadu.com [95.215.58.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB863161A1
	for <sched-ext@lists.linux.dev>; Tue, 25 Aug 2026 02:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787624823; cv=none; b=FkNAIFdH1qeb+yNt2V7aB+HpW9hJZ+CNzUYJUb/igR8nbvU36lbs5/b8+eBTwwtjUnR9xYtxreJklwgOz+2KbZAMBjxGXINgrfZUzajCPt2OD0JsFBHAWwlPueK4B97S4HMwVl+Lrlo0jRG5U9MEabJrs2OEVriTaIINxvTAqWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787624823; c=relaxed/simple;
	bh=HupIf7Cl7uDpKXaRUm6oRZH6XKwPsDXMGDPyL3LI/DQ=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ji+JDQioSEx4WjQ5F1WVDHhuD9ULeRoOdJTkq9MvRSbN2jF6TVJwQCC8ndrvlKrEeDZVgUjYC3A28HGeuztKRxlfSzb2BGGKSwCE+FxNb0Ep/zh70pjfV/BAO84RQ7ETfqB7S8RyYvH3Fza20ayQe6SxkyKIpHf93URXnI46Kts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rYPt255s; arc=none smtp.client-ip=95.215.58.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rYPt255s"
X-Envelope-To: sched-ext@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=HupIf7Cl7uDpKXaRUm6oRZH6XKwPsDXMGDPyL3LI/DQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787624819; v=1; x=1788229619;
 b=rYPt255shSOoPDwSBA3kwZH3yhrl90tL6tILsDn7BGyONId4EDSlcOtoItO4DdBU8DfIJB9w
 EcOaInVvaOTVoffGgC1D7nWUjGlWFwrgpRfbb+4hDrCUg8EH+AP2YwBM/Pk/2DDl0FbqRx0yMBF
 MwiyvtiPThW7UiI5CBX/FvEw=
X-Envelope-To: sched-ext@lists.linux.dev
Received: from [192.168.110.173] (223.70.160.239)
	by smtp.migadu.com with ESMTPS id 733aeb1c8d3e640f;
	Tue, 25 Aug 2026 02:26:59 +0000
X-Mizu-Trace-ID: 733aeb1c8d3e640f
X-Migadu-Flow: FLOW_OUT
Message-ID: <596acf85-5332-463b-a4d0-a8fcfca903a5@linux.dev>
Date: Tue, 25 Aug 2026 10:26:51 +0800
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: cui.tao@linux.dev, void@manifault.com, arighi@nvidia.com,
 changwoo@igalia.com, suzhidao@xiaomi.com, emil@etsalapatis.com,
 sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, cuitao@kylinos.cn
Subject: Re: [PATCH v2] sched_ext: pass the initial cpu.idle state in
 scx_cgroup_init_args
To: Tejun Heo <tj@kernel.org>
References: <20260824142817.568085-1-cui.tao@linux.dev>
 <20eb5e65cb330a6f9cc41781af302873@kernel.org>
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <20eb5e65cb330a6f9cc41781af302873@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello, Tejun,

在 2026/8/25 00:54, Tejun Heo 写道:
> Hello, Tao.
> 
> On Mon, Aug 24, 2026 at 10:28:16PM +0800, Tao Cui wrote:
>> +
>> +	/* whether the cgroup is configured idle via cpu.idle */
>> +	bool			idle;
> 
> In sched_ext, a bare "idle" reads as CPU idle state (ops.update_idle(),
> idle cpumasks, scx_bpf_pick_idle_cpu()). cpu.idle is the cgroup analog
> of the SCHED_IDLE policy, so please name the field sched_idle instead.
> Renaming tg->scx.idle to match would be nice too.
> 

Thanks for the review. Both are renamed in v3: the new
scx_cgroup_init_args field, and tg->scx.idle -> tg->scx.sched_idle
as a separate second patch in the series, so 1/2 stays minimal for
stable backport.

Thanks,
Tao

> Thanks.
> 

