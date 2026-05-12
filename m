Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED0D1DF75B;
	Tue, 12 May 2026 21:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778621620; cv=none; b=BKvjbvY2zMfeBPdPsKUwNwJX/Eq2b2SW3+SoQ6fSANUQcd4bbPL5ZHYVJuqh7r691CEmEUr9ADQxojTo1Jr8bd9seRdnla8aS7a791LTtjTtwS40r7ywDXRxVdQJXSPbBnbbvmTILAPrrBTOFJ84hlIw2W/N8V02YB3praGvoW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778621620; c=relaxed/simple;
	bh=xkv4rowQSbrlz+DtnyHzM6Q4ND/p6P6zl8wnb2i6vJM=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=llV1Sx/6SbgRPxRBkFNjuaXXBCGzNvGUvi0APiKpvvvyu/EO1hMpbb0tNyQSR6yuywJilpaJWVEsWAf90zL1d6ABnjaTMhKnkXI7z7uoEB5dtr98W8AugPPzesprB3sIH3JBTmJH5SzfkzpzxJLyrFJhGPsYk/kKwgHynA9rnZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pgYjRTKo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pgYjRTKo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BC6CC2BCB0;
	Tue, 12 May 2026 21:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778621620;
	bh=xkv4rowQSbrlz+DtnyHzM6Q4ND/p6P6zl8wnb2i6vJM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pgYjRTKoB8kCkrQVOptC7bXilp03wdoql7vYX+t19zrvSLz38SvGGs1jSRDZhbzCp
	 wkEI+ktgZMztEDxknKtVJtbCPKJPK8e6okjXNWmoJUvvFgOQmIMeXzlBcvTYYPMyDV
	 sazpWKtzCsHUCaiAcuxSFhB1W1c8XVZyZDto/noUHVv9vAT2bwGMgQpI3ijUKWvW2f
	 OJOxG+pEApFTwaSh0ZxIcn0tSAnveLIqXlw866SsueKvNyRZ165XJaKEWz+9F5IrTu
	 yuVwj+x08w6q4jADSw5KXWxoRU1/8ilfqcyno3sqmOFiqBP3AiGrKwP8Ke5ezaDo4f
	 99NBB9/dQ8ALg==
Date: Tue, 12 May 2026 11:33:39 -1000
Message-ID: <a4d0061bc4e7809c3a6d2ddf33b1b363@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev, Emil Tsalapatis <emil@etsalapatis.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.1-fixes] sched_ext: INIT_LIST_HEAD() &sch->all in scx_alloc_and_add_sched()
In-Reply-To: <6ec4a29c923e672d0dcb6f3ac037397e@kernel.org>
References: <6ec4a29c923e672d0dcb6f3ac037397e@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

Applied to sched_ext/for-7.1-fixes.

Thanks.

--
tejun
