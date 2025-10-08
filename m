Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604BD34BA39
	for <sched-ext@lists.linux.dev>; Wed,  8 Oct 2025 23:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759966589; cv=none; b=MhtY/7i63/mV9g5dZDAC8rkmeM8VhMUUcbgaeiSZvTcNSWZrGm7hkRYyfcC3aeeLYwUCMKvcbf5QtSA23cloQhPWQr87F8f20aBrTtRv2KTj9Y/lIR7PM5sxWckvHI73PU4TTSYzBdXNNDi07+xwG9I3V2Z+pw+eXK8iaeKzjUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759966589; c=relaxed/simple;
	bh=tSkEwcX+QOJY9rb7jQYRF0dF6ybTnZ+LXKsa4GrPEbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kxzwDvfxBbcx/eroq9tgqWaQt4nx70Nq122VctOrH+xOnmXz3JXJC+flgOpN5oa4I3RWeq6GqcR7+nTT6vmPg/Pol7iwy5atba0mdzEfwm5Vwr4Tiop4FImxMgNTomtAE437fmZKKdyM6QI+urC1OZe2xjAN1d12z4q2AKMYCk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OdX9LiYk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OdX9LiYk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B317CC4CEE7;
	Wed,  8 Oct 2025 23:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759966588;
	bh=tSkEwcX+QOJY9rb7jQYRF0dF6ybTnZ+LXKsa4GrPEbk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OdX9LiYkGwqyzhp7g+HVUViN7Opl1fbSkdmHF7RDsaegOatqkwOJu4kxWWAiW3YWL
	 ebWJhcGoJHAmuZEbfduGHmC0e77J32S6LFAZWiV70/fsyGIR9vJo9nIkk8+NHG92fP
	 W63uLdJ1HEL2yIJ5Q7XHLYAC/7jg2h2IKmRD6OFkZo5ypYuQMAusJ/5mbFAf3k8ceG
	 M58c61BWZOxNt/EAagEou84msHvSkVPACcU3HN30yh92YOsXWe5Zise12O3sxLEbLm
	 qxeK/oB1oTr2Es2lrXnFZ41Nnx6Q0AKCPiB4lNTRKJIBX/YmUhmWB8MTrA4gbmVoTP
	 y7GYfTSK/vrwQ==
Date: Wed, 8 Oct 2025 13:36:27 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: Phil Auld <pauld@redhat.com>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev
Subject: Re: [PATCH v2] sched_ext: Allocate scx_kick_cpus_pnt_seqs lazily
 using kvzalloc()
Message-ID: <aOb1e7R1lAGVGH-2@slm.duckdns.org>
References: <20251007133523.GA93086@pauld.westford.csb>
 <d1c0eda5206b01fd670e148bd5ea0d56@kernel.org>
 <aOYAV2ZQvMt5aZxu@gpd4>
 <aObPQF1-o-Uek7bd@slm.duckdns.org>
 <aObcIMFpUoMy7vJI@slm.duckdns.org>
 <aObkkKf_UCHySRGz@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aObkkKf_UCHySRGz@gpd4>

Hello,

On Thu, Oct 09, 2025 at 12:24:16AM +0200, Andrea Righi wrote:
> > +static void free_kick_pseqs(void)
> > +{
> > +	int cpu;
> > +
> > +	for_each_possible_cpu(cpu) {
> > +		struct scx_kick_pseqs **pseqs = per_cpu_ptr(&scx_kick_pseqs, cpu);
> > +
> > +		call_rcu(&(*pseqs)->rcu, free_kick_pseqs_rcu);
> > +		RCU_INIT_POINTER(*pseqs, NULL);
> 
> Is this safe? I think we should replace the pointer first and then schedule
> the free via call_rcu(), like:
> 
>         old = rcu_replace_pointer(*pseqs, NULL, true);
>         if (old)
> 		call_rcu(&old->rcu, free_kick_pseqs_rcu);

*pseqs is the deferenced per-cpu pointer and we're freeding the struct
that's pointed by it. Whether the struct is freed or not doesn't really
affect the pointer storage. Let's say the struct gets freed between
call_rcu() and RCU_INIT_POINTER(). Then, *pseqs is just a dangling pointer
inbetween until it gets cleared.

> > +		WARN_ON_ONCE(rcu_access_pointer(*pseqs));
> > +
> > +		new_pseqs = kvzalloc_node(sizeof(unsigned long) * nr_cpu_ids,
> > +					  GFP_KERNEL, cpu_to_node(cpu));
> 
> Don't we need to allocate the struct as well? This should be something
> like:
> 
> 	new_pseqs = kvzalloc_node(struct_size(new_pseqs, seqs, nr_cpu_ids),
> 				  GFP_KERNEL, cpu_to_node(cpu));

Yes, will post the fixed version.

Thanks.

-- 
tejun
