Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD572338598
	for <sched-ext@lists.linux.dev>; Fri,  9 Jan 2026 10:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767955182; cv=none; b=U0FRWSdE7A+VJ8yQZTbJbz4ppJzyfkj0IZbdzIHbF+eOOf1NEzsAYiJTDC7PXBtSN8hXY5hafhtlbGz2NKxqOZB/MePEnncS4Gr4yas2D4aEoD3fRskcEBFo+M25/XEYzZiy6zyBsUv0pHDYEVvhEWk3c5rCz/QzSz0Zvg5x6pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767955182; c=relaxed/simple;
	bh=Krfno6iKqZjj33moHy0mMr7lRAw2WG/uVScFqJdf9wU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s/ECf1Tol+FNMtGscWlPErI6X6TfLPDWkCTSC3soyhlIfPUkwi5txp8gJBxX1v8YvAL1/Ro81y4NcEtZSTkhxIKXUvjMVExgloyBH7DkvqijP5wi6UlVtDnFZk2sIHA+muWE25iBscinwwIJ41j6Sz2lN3mT4xWOOkoN8uyRCI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=agvGZXPI; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="agvGZXPI"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767955178;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wFWh0TKBXo0fcIfH7thRmiyrZpbkNllhKoY10ttf5IQ=;
	b=agvGZXPINrWg98zBUNtCrXSvMdFTyM2kew48vB/lDdDc8TrQgNa3IBa96iQM5AjxuVOSd8
	8MOy7P0NA12sNgMz8vDCJ+ngqtwfavmve4pwrk0IzIjmEUUtjKkC7d1JDAVlEgJ2mgvHdg
	i4PagqCB4H99VXsFwPyzkqjKxicbNvs=
From: George Guo <dongtai.guo@linux.dev>
To: arighi@nvidia.com
Cc: changwoo@igalia.com,
	dongtai.guo@linux.dev,
	etsal@meta.com,
	guodongtai@kylinos.cn,
	linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	tj@kernel.org,
	void@manifault.com
Subject: Re: [PATCH v2 1/1] sched_ext: Add error logging for dsq creation failures
Date: Fri,  9 Jan 2026 18:39:16 +0800
Message-ID: <20260109103916.93454-1-dongtai.guo@linux.dev>
In-Reply-To: <aWDUbVsJXth8KuqW@gpd4>
References: <aWDUbVsJXth8KuqW@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

> Huh? No, we already get an error message both in dmesg and in stdout when
> scx_bpf_create_dsq() fails, so I don't think this is required.
> 
> Are you sure you were not hitting other issues when your scheduler failed
> to load silently?


Hi Andrea,
Here take an instance.
You need add bpf_printk in BPF_STRUCT_OPS_SLEEPABLE(central_init), 
even with dmesg when central_init fails, as central_init have multiply
error return.

Thanks!
