Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526153B2FD0;
	Sat, 10 Oct 2026 08:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791621533; cv=none; b=M/R9p99ov78RD/di1HdDrNUV5UQcENrv2Dt3O6UyGV6f1YVwk4Mmm+1Mctm6T7+nA3rSIpMvDtzj/uk0q3M9YVz7tNpw1w9oT8moO9jW2qREMh1nTwOsyz8k95DBpDXjar7ei1zbz6DsXYr9hEjZ9rKI5c2Yfs4vNGsahEAT0Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791621533; c=relaxed/simple;
	bh=6Y7vYf/xc/TsRZfeinhAcNhu9VUF65Y4YoGWlsYueBI=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=BCQosLKdNGI6XpCvulMqw3U9Q+dmQONIetJqWVXg7a5ASVqYiK8Wylb9KsrWbNFj4ktwjEdNuxQKv4niqX9RTj3dHNwhBYgJEXX/7DeoBbIRo7Hjt/zQNnvq4ZIi/YodhXIlRl2Bo8WLsxl/52WMYGOxb5VqZRndBiflJk9YykY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Exmkicwy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Exmkicwy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65FF61F000FF;
	Sat, 10 Oct 2026 08:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791621527;
	bh=6Y7vYf/xc/TsRZfeinhAcNhu9VUF65Y4YoGWlsYueBI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ExmkicwyB9PupmWVbnQqzcJ1MCtrHzNZknSdPGyAdhA1hkuWr7SrflYugw2wUwwl8
	 JKZjCIRVPUp4LGpFqZkmiIeNyQxcDcDP1ckzxTkewRxshzcvmPbfyqKv8Z789g+qsM
	 cxJpkOSpYppKdbTCLLlDHMKGmwi0Kv5RUhSXEjQ569I8YJOQzyXEfSVROrHrB1M16T
	 A4uu9NKRKTWcTVGXc4X/4JmLaYhmAcmJpyqKSoA3I0kB1tdA+WyEAMjqnBitqe7Bly
	 mGpBsbiAcMeCNKzR+cgKBwzv8YZ//BBgC4dXB/ecCTB7i1X0KrQVgV3Oqv1vJIx7ka
	 aUSYHv+biplaA==
Date: Fri, 09 Oct 2026 22:38:46 -1000
Message-ID: <85e1c03116c07e0192a982674199d815@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>, Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>, Dan Schatzberg <schatzberg.dan@gmail.com>,
	Xiangyu Bu <xbu@meta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.3-fixes] sched_ext: Fix stall when a task
 enqueued with SCX_ENQ_LAST lands back on its CPU's local DSQ
In-Reply-To: <2b405553751fe811b4cd2c24f307d961@kernel.org>
References: <2b405553751fe811b4cd2c24f307d961@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied to sched_ext/for-7.3-fixes.

Thanks.

--
tejun
