Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A4147DD4D
	for <sched-ext@lists.linux.dev>; Fri, 15 May 2026 13:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778852572; cv=none; b=uen7pKuVbYaz+3LP2asW2++mAVJOSnL29PVGQAPHmGrctaXcES9L7XIfAv5xmbYTvLAgyS4KzAxhYQpN/keyguPgksE/hCs3OBbXEuXTKXbwpY1BEVDpV6PtdLEbX4fQyyL4pQ9xXi5jvEmP1lmgyrfm8pgNp09kzq/cnckkDHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778852572; c=relaxed/simple;
	bh=h8bZ3uhktPXQNmYiBcZU0/0R1MMuxkAs3WosmGX3ZHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qsIrDt9Aiiy3DZsR6ZNHQUD3XxD6ikVWMp12hgEVBclMsUdPzVNhJIWioGjtdp0wgsZVcQiloXro86p81e3lOaVyJpTKXJ75AoofDBe9oXp0CITAjJLysw9eRLFqa9e2LpzVZzJQYlCgAj3mld01KxENp3J7tzsH6MYP13GIjzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qn3C4LMo; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qn3C4LMo"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-834f1075805so6438482b3a.2
        for <sched-ext@lists.linux.dev>; Fri, 15 May 2026 06:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778852571; x=1779457371; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I/+MKIKiHSCLZeMafTYwHrhWWcki6gnLsCGxe01Koz0=;
        b=qn3C4LMon1HEiML1HoKpvR5sdKDqjtbqgfNjIuGAhOeQrIwShPbo+wyICGfGw4fG24
         FalhwIJ27jmnVBtO7P1EYiY5mDvCwq7rZoGT9Ud9YMSHD4XklmMsrGMGkFnWLQidPi00
         XDPEXH5UwZpfeDWIkOz6t14cgtHMGWWgREy7pqY6EKbUBvTtMk4sbkbvfcAUPk5P1Ukv
         MjvBHNSUxZvpODQOcpTXQqAjXCNAbx9vV0B6jcXNc+YTC+uRItJySUB5iFShUidodbfb
         MWCbXHHa/CqX4H4q2ffzXoIXDmCBEzSJfqvELTD84gZyyx7av0siprjy0WJkkyqe6klx
         Lphg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778852571; x=1779457371;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I/+MKIKiHSCLZeMafTYwHrhWWcki6gnLsCGxe01Koz0=;
        b=ipmoK0g6dRytVEhMFbSFxOL2jCWpL1UsXkiDiu4sa2dp3ci0bEGNoy31OlWX8sOC97
         QwjeXUpZbIRjqClgsIlDmAeiuM7kU9eUs2Fi91fH8KCV6GPUVyfm3o2Jw6nb4jgg15Rg
         YxbzhnaNQzk+9Cysk9jAeZ00vEXJ8HyWAKSdFd5A+V8BYgzT2k0MFAfWOKJAob17suJQ
         D87OxrVlDoEZRcj9wdfLF5Af5kx56elbKD/5xl1jEXO3KENMU/i8pbuj5xVK6T3g1rLW
         WZkvwfl7/Satj/aNW2Hwyt0kTQwrdKdYx6RgBQG8ZnX5iohmigmbZfPL5Ug6kJS1bLy4
         l9IQ==
X-Gm-Message-State: AOJu0YxMn1do3BWdew/+8k8NgvZGf7b4i644ADwZTgPG7BvRjSQKBGrG
	SD8nvn64yD+2VEaHyJdlYl3wRNPbfc82jkRojdQG7uhCD74QhRhS+7PW
X-Gm-Gg: Acq92OE06U+IZbKBi7pSNTgfCJZUfpZiq/zx6+T8FBOLkJAyqfhf3W6tcZIUG6HiGSK
	zSFpXBKrTFtvp34/g86y7YEnpprIpdW4dmE2o8fLBKij9WOvBCZJuB8uzXkNpvHhl2rBSbVM8kx
	2iIlZnHG0A6PgMqqhpH5NQ5ayFv2RvvwpV+YjyV3HBxiZck3GVEuDNBnSA+suq9ws0MCMLQpbZC
	MMSXyXgA3W6dtw63aGqr73LkV/mZ4vHdcAqUx3Iaawu4jmICl2OqqFrdi6weKeSvPf9Ow8rOMdB
	ATPzT8NM40H7cLsfArEiIYoL1PhvTm3xZAShFbuXJ5N5LubSf2xS9QIgstjatXVK1ynjRYT3MEg
	Qi5QFiw/VRfLAKuJ+7of7lvj7yVbQABhA4lz2UZ3WCtwWtBPTeWGCxn2dxR1bfPRJwUthzMONrc
	EGQTsZNOJyrnvY7TfqaomNSIA5mWKPdttOYpWxjQi9seK/kh/5pqYBo6+Qm+Cq5D7K1IBXVdont
	uk=
X-Received: by 2002:a05:6a00:414e:b0:82f:4a4d:377e with SMTP id d2e1a72fcca58-83f33d9d741mr4820867b3a.28.1778852570730;
        Fri, 15 May 2026 06:42:50 -0700 (PDT)
Received: from cchengyang.duckdns.org (36-225-72-95.dynamic-ip.hinet.net. [36.225.72.95])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f19f7ccc7sm7405950b3a.58.2026.05.15.06.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 06:42:50 -0700 (PDT)
Date: Fri, 15 May 2026 21:42:46 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: Andrea Righi <arighi@nvidia.com>
Cc: sched-ext@lists.linux.dev, Tejun Heo <tj@kernel.org>, 
	David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>, 
	Kuba Piecuch <jpiecuch@google.com>, Ching-Chun Huang <jserv@ccns.ncku.edu.tw>, 
	Chia-Ping Tsai <chia7712@gmail.com>
Subject: Re: [PATCH v3 2/2] selftests/sched_ext: Add dispatch_cookie test
Message-ID: <20260515213811.Gc058@cchengyang.duckdns.org>
References: <20260509191223.168648-1-yphbchou0911@gmail.com>
 <20260509191223.168648-3-yphbchou0911@gmail.com>
 <af-qa9u5S9NJdWR1@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af-qa9u5S9NJdWR1@gpd4>

Hi Andrea,

On Sat, May 09, 2026 at 11:43:07PM +0200, Andrea Righi wrote:
> ...
> > +void BPF_STRUCT_OPS(dispatch_cookie_dispatch, s32 cpu,
> > +		    struct task_struct *prev)
> > +{
> > +	s32 pid;
> > +	struct task_struct *p;
> > +	u64 *stored, token;
> > +
> > +	if (bpf_map_pop_elem(&queue, &pid))
> > +		return;
> > +
> > +	p = bpf_task_from_pid(pid);
> > +	if (!p)
> > +		return;
> > +
> > +	/*
> > +	 * After a successful fresh dispatch, store the token. On the task's
> > +	 * next dispatch (after re-enqueue increments qseq), the stored token
> > +	 * exercises the race-detection window in finish_dispatch().
> > +	 *
> > +	 * scx_bpf_dsq_insert_commit() always returns %true when the preamble
> > +	 * passes. Stale detection fires asynchronously in finish_dispatch()
> > +	 * with no BPF-observable signal. When using a stored token, always
> > +	 * pair the commit() call with a fallback scx_bpf_dsq_insert(): if
> > +	 * the token is stale, finish_dispatch() drops the first entry and
> > +	 * the fallback dispatches the task. If the token is still fresh,
> > +	 * finish_dispatch() dispatches it and the fallback's CAS is a no-op.
> > +	 */
> > +	stored = bpf_map_lookup_elem(&last_token, &pid);
> > +	if (stored) {
> > +		token = *stored;
> > +		bpf_map_delete_elem(&last_token, &pid);
> > +		scx_bpf_dsq_insert_commit(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, token);
> 
> I think we should pass 0 instead of SCX_SLICE_DFL here:
> 
>  scx_bpf_dsq_insert_commit(p, dsq_id, enq_flags, token)
> 
> > +		scx_bpf_dsq_insert(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, 0);
> > +		__sync_fetch_and_add(&nr_tx_stale, 1);
> > +	} else {
> > +		token = scx_bpf_dsq_insert_begin(p);
> > +		if (scx_bpf_dsq_insert_commit(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, token)) {
> 
> Ditto.

Ack! v4 wraps the arguments in scx_bpf_dsq_insert_commit_args with
slice=0, which preserves the task's existing slice instead of zeroing it.

> 
> > +			__sync_fetch_and_add(&nr_tx_dispatched, 1);
> 
> Also, stale detection happens asynchronously later in finish_dispatch() with no
> BPF-observable signal, so commit can return true here and write the buffered
> entry with stale qseq=N, but the counter is incremented before finish_dispatch()
> runs. Later, when finish_dispatch() processes the entry, it detects the qseq
> mismatch (task now has N+1) and silently drops the dispatch. So nr_tx_stale
> counts "attempted stale commits", not "detected and rejected stale tokens".
> 

Ack, the comment now reads "counts attempted stale commits, not
rejections detected by finish_dispatch()".

> ...
> 
> > +static enum scx_test_status run(void *ctx)
> > +{
> > +	struct dispatch_cookie_ctx *tctx = ctx;
> > +	cpu_set_t cpuset_one, cpuset_all;
> > +	pid_t pids[NUM_CHILDREN];
> > +	int i, j, nforked = 0, status;
> > +
> > +	tctx->link = bpf_map__attach_struct_ops(tctx->skel->maps.dispatch_cookie_ops);
> > +	SCX_FAIL_IF(!tctx->link, "Failed to attach scheduler");
> > +
> > +	CPU_ZERO(&cpuset_one);
> > +	CPU_SET(0, &cpuset_one);
> 
> This is probably fine as it is, but it's worth noticing that if for any reason
> CPU0 is offline the test is probably failing.

Make sense. Fixed by calling sched_getaffinity() to find the first
online CPU to avoid failures if CPU 0 is somehow offline.

Thanks!

-- 
Cheers,
Cheng-Yang
