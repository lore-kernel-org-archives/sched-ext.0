Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6D813E41A
	for <sched-ext@lists.linux.dev>; Sat,  4 Jul 2026 00:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783126469; cv=none; b=cKMs9L5zDWEOYLbxNCf2y30IxmOtLte3vm+k2Rw/qefGUilP85K1Barjs+DT8tTGcBmdMYrA0KufHly2xYiz4btZOTvslGAB5IAD4uKvJuIW3Hqkhw9omLfbmvP0CWNi7UZfUV0ClYqUUd7zsve05vYGSKBTr1Qq6fE+Yg3TmUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783126469; c=relaxed/simple;
	bh=KP7OqOlEjGQOhIjncSTbFcm/g1hHrPgublMIb+VjjGs=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=XwGJOyMjdUtYwCnawieIAravlSJ64PqJPi2AKrKPCS85K2/8Uje+xh91HRwVUdFODrCJaj9W3m5ZoM5hn4bMiy7Vu+d0OTOAVzGdEsXsZsgjNRNZRxrxqcfQZeM3foeDdVJU3xGA36rP5KF3K7QhGiuSTgfmhlLuM2aTx9x/kbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=noQbJkTi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="noQbJkTi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 910BD1F000E9;
	Sat,  4 Jul 2026 00:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783126468;
	bh=KP7OqOlEjGQOhIjncSTbFcm/g1hHrPgublMIb+VjjGs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=noQbJkTizh2XSECPLdy+Au9JoU6cKkcw/f+i6KEiGJOSInQIhGnHZulRpc+Fk+8l1
	 T7fYSE2YGwi27xYEIgGPoS1M68nCbVytcZVr6YfD9R4+c4ku6rlsuXT7iPMADfBZlU
	 gak79Uoe+oVYug3gV06ONWeIFWty2UjTXWmtmxO9X2SjkAadAx8z9h1laQTGaTObGX
	 CSziWVH5f/JtbTz809HWnyjsqUBemDyMpr9wNhLcFQifJRZ3XhnvUGbRtyJYiIsioR
	 Nmz+O+8yfLOiRsvWvEY0+4wbtPhfeEhpqzuI8ThEeK3wiEuDQGQRisAfmpcUUD0YAO
	 LWWKIFyNFcNVg==
Date: Fri, 03 Jul 2026 14:54:27 -1000
Message-ID: <002ecceae2a2642f45bef803d5c5c8ff@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: sashiko-bot@kernel.org
Cc: sched-ext@lists.linux.dev
Subject: Re: [PATCH sched_ext/for-7.3 16/32] sched_ext: Add per-shard cap delegation for sub-schedulers
In-Reply-To: <20260703111746.4F07A1F000E9@smtp.kernel.org>
References: <20260703080159.2314350-1-tj@kernel.org> <20260703080159.2314350-17-tj@kernel.org> <20260703111746.4F07A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

> [High] Partial allocation failure in `scx_alloc_pshards()` leaves the
> `pshard` array exposed, causing a NULL pointer dereference if the BPF
> `ops.exit` hook reads its own caps.

v2 will free and NULL sch->pshard on a partial scx_alloc_pshards()
failure, so the !pshard guard in scx_bpf_sub_caps() holds.

Thanks.
