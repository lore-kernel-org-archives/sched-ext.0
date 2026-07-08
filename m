Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BE83D171F;
	Wed,  8 Jul 2026 19:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783537774; cv=none; b=U5mTsIEh9PCd4aSLKSnz2xwtfzgwkI4tPoCpLAjemMo+0FDXalG+95jgHDGabvQiwdy6pVw9ZMLW8MgxSz1ZoGeZMB35GJBSTtBLG+/EtRGvRp76ZFPRXriLINQ+IUVdGeMQB8cOgISbPJ3yY9a+mnXUo4ZgpoqT/+A3zQpX0MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783537774; c=relaxed/simple;
	bh=hHRzmVrAYGQJs/ER855UnBsk5WsDmKkPyObUbY7w4Uo=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=RayyCU2Vk327GM8WQGpCBPuhsz2rRGcMC2mkvEo7TJVSHd61k2+DC0ArzYDg+nEREgTaglZEGad6KxcqDFyiTbedcXWkPl/7mI/gGZeChY1lanQSO0echhWYfa3ijYDcVOJi8PfVOCNKEE2/ZyzcnmsNUFG73ihW233tdKvNNQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PGLixQpM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PGLixQpM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A9181F00A3A;
	Wed,  8 Jul 2026 19:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783537773;
	bh=6uFXJhB1YayhpTSh7+hTRLBbBKgPMouJTrFGkj8DZm0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=PGLixQpM/Vv5fQ3pVmmQIr83ZPQdCH0eEllG8qtuuJhDSqK9sA14FMnKpTzC8RKwp
	 D/4/3lkRERiATO95lm2+Qj8GeGEd3Qyy2r93fX7KtIt2VckB4GxLt3ylgwESqgWQhM
	 jKZETHv2M93jQgKSFcAGVdyvaDvGLWyPtbTqVWJZv0gPFi1tf2A7mVW4H7v1/p8m4J
	 9iqAon7decky9/Ija25besT5PWIJtQcTEn/ye1UETocvDXoyIKIT0Swmcu+mbsSqID
	 W81gIBpr8MXHua2AO23gCrEYfFlN0q5AN66jsVzMJMrU/cVN904i//hN1wGGb4bqbH
	 PZd7RDlHR/Uag==
Date: Wed, 08 Jul 2026 09:09:32 -1000
Message-ID: <424ae0535f36eddd4d7b6994553c3268@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: sashiko-bot@kernel.org
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 sched_ext/for-7.3 11/36] sched_ext: Add CID sharding
In-Reply-To: <20260707003007.49D081F000E9@smtp.kernel.org>
References: <20260707001229.1410929-1-tj@kernel.org> <20260707001229.1410929-12-tj@kernel.org> <20260707003007.49D081F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

On Tue, 07 Jul 2026 00:30:06 +0000, sashiko-bot@kernel.org wrote:
> - [High] `scx_bpf_cid_override()` leaves newly added shard tracking arrays stale and inconsistent.

At this patch cid_override() only remaps the cpu<->cid topology; the
shard-tracking arrays and their rebuild arrive in the next patch and stay
consistent with an override. Nothing reads a stale shard array in
between. No change.

Thanks.

-- 
tejun
