Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793898602;
	b=ygLzLyCN/on9jivujezSRQ19KFuTDhXcOKQJlku0E37KnOtUfca2DQL015YbhsWg9SKA
	 JxAsweIfbDThmQAKJJ4Kap/ygB0wXXFs0N/p3uIqw6Lz2iF7C4cWpVPUX5jYVmymEWMv5
	 6bIo7GzbjyVWfgMz7KT3bSodOK0QbgcoOFDpiL+bsIIPnyzXNkbszH+hXMCRWt0MDDMv3
	 o7IC+jMC6BypuB4gJsc3591xJTS+oaCUPz0VGLR0F5L9envPCxoQiFGgpTTVt3srtBW5Y
	 zBVv7wleO4Jo4Z8tG6PiDCN2COCMqU5XN34AtI7SsgeXQYK2FKTdMC8q25H0F9a87BQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793898602;
	h=Received:DKIM-Signature:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=gZkm2QxfDfYCVvyQBMZSCLkQzLHLrn3ojCeBtZmNTQ0=;
	b=Cl1CqfUnDM366tioBTX2tnAkZ6INPytFzgZrUE5HKBKTr74EjBw4gRQneLqagYGVxIAE
	 SskCx5oJ2b0XUXHpXzQkvXLvj1FuSiHeMyzO933RVRCsdKXz7hmj2YE2Voagp8IctkkGR
	 7Br5gntff3R0K9VIP3YvzGsTjEvZ1NC63awf2C+gt/uoiar0iaGzK5vil4O+uvft9Ry7n
	 LOSTiCJaAZcCem8wuRb5v6s7ei2LTtccxZFlm7LM5pD+3JWs59Q09oHk/4jL+i6VWhJo3
	 prLLiBKGm44227EA9hf52Z1Tar7wmjWh7zbsbpXTDdjv2JijxIygoOmvhRe5N6+gq+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="dHBR/ye2";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFEC0606A326;
	Thu,  5 Nov 2026 17:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dHBR/ye2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E1A61F000C1;
	Thu,  5 Nov 2026 17:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793898601;
	bh=gZkm2QxfDfYCVvyQBMZSCLkQzLHLrn3ojCeBtZmNTQ0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=dHBR/ye2ZrPb5Er9jk6li27/jk8CQjBqhuooldMh3jAdv2nRJqU8gxzuobpcKac2S
	 HdY/+H4aYO844IjRRf+glACBWduLkiVR2jzfyNXPEVOOgduGT4oRAmXpzPAtik2jtL
	 ZnkM6/sN+uXwdw0hxIRfM3+/fmILps4F6cgWcLkeG7RrP3AAzYBRIkWwgO8xJBu8up
	 UKP6FhNYpsT3Ciu2KOVgOZAfM1viSl7fYC5k8PZNjaWHyQeMSrhxWHZFJTwvJbKdOS
	 YlM7PiBYlu6LfERf+6ZWSu/AKSNNvC1Isih9KVBd5AuIWhup77aKCJdNcsmTH5TgJW
	 1ayGKuwrWfcBA==
Date: Thu, 05 Nov 2026 07:10:00 -1000
Message-ID: <08f0886ea1c48eed84bf6aadcf921530@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Zhang Qiao <zhangqiao22@huawei.com>
Cc: sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org, void@manifault.com, arighi@nvidia.com, changwoo@igalia.com, tanghui22@huawei.com
Subject: Re: [PATCH 0/4] sched_ext: Decompose scx_cid_init()
In-Reply-To: <20261105065013.784398-1-zhangqiao22@huawei.com>
References: <20261105065013.784398-1-zhangqiao22@huawei.com>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hello,

On Thu, Nov 05, 2026 at 02:50:09PM +0800, Zhang Qiao wrote:
> scx_cid_init() grew into a ~230-line monolith interleaving table
> allocation, the node/LLC/cluster/core topology walk, the no-topo tail
> and the shard range finalization.

I don't think the refactoring makes anything better. If anything, the
result seems more complicated than the current code.

A function being long isn't an automatic reason to refactor it.
scx_cid_init() is a linear sequence of steps that each run once:
allocate the tables and masks, walk the online CPUs node by node, assign
cids to the CPUs left without topology, warn about fallbacks, fill the
shard ranges.

The current code reads top to bottom, and splitting it into
single-caller helpers doesn't make any step simpler. It just adds call
boundaries and a builder struct whose only job is to carry the counters
and masks across them, so the reader has to jump around to follow one
sequence.

> No behavior change: WARN checks, error paths, shard policy and
> publication timing are all preserved. This is preparation for
> follow-up fixes to the partial-SMT core counting in
> calc_shard_layout() and the single-core shard hard-cap corner case,
> which are deliberately kept out to keep this series a pure code
> motion.

Can you please send the fixes separately?

Thanks.

--
tejun
