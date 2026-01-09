Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D969850097C
	for <sched-ext@lists.linux.dev>; Fri,  9 Jan 2026 10:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767952937; cv=none; b=PE+lIcd/6cQtj0lHthdIy+aABX7oJ0vI2KmDMSFMO6bo82tYPwGoGNm/BkH66Rv/TGWDIWeDFi/dOT5w5Jatftbpm7R5y7CuU8i1cJagyvDTRroDhcKgzsnA0rcTwQG9oN/YYzpLHwFZCS+v6ARUcFDId8k7CHUaPUrzbLVs8fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767952937; c=relaxed/simple;
	bh=wCtmccf93OSdvJM0ci+C4UIcKWbDzQZFco3p8oFuVu4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HTMT2pJgeFXXjE1A8dPgeUJhGFPmwjE/Wj75sjbaGPu56hi4yQegDfYKY831HnjffKdB3CDLyhTwaFGhv0h6yii8P3O2clyBpsXYj+c1ReQFrtcuHNich+RRbOny5nfwOjsxbcMVB8jTkcFZElcgp+KBleR2EZFefamwbdsIJYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UY4sSDU4; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UY4sSDU4"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767952933;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wCtmccf93OSdvJM0ci+C4UIcKWbDzQZFco3p8oFuVu4=;
	b=UY4sSDU4SbBiprpUUfacSNYoEhyPsOYsoGhlObdr+VOEhbsui0Vc40PevrBifNaPWbaQ68
	EQ3WNpWlBz4HdHr1eTiQLewky4hmKXo8oGAb9wGSvNH0a/39742SxzbDjd3/qf/M3WGY/9
	+yxCO3lFKI2gGM85X42qOYCil8LeZaw=
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
Subject: Re: [PATCH 1/1] sched_ext: Add error logging for dsq creation failures
Date: Fri,  9 Jan 2026 18:02:06 +0800
Message-ID: <20260109100206.93018-1-dongtai.guo@linux.dev>
In-Reply-To: <aV9N5UxymrzJ9jSP@gpd4>
References: <aV9N5UxymrzJ9jSP@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi Andrea,
I got the similar dmesg too.
It seems that it's not necessry in scx_simple.bpf.c indeed.
I will send v2 later for your review.
