Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE6F21A457;
	Thu, 26 Mar 2026 03:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774496832; cv=none; b=G/AMdkmn8IkfK+5fSFvyx9272dpS/XsX0iSAUcY2EHIjXvtapR2uHCA/M3k3of7mZHHYRw1fN3YRGZzzVxcgtKUw6wAVOSnWVFmeRhoI+UPyIvrC/i99jsB70T+NCyWJURWGTrAj0iIk/6lMOaSGi7r5Ri7maDTNrPDbl0ImHN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774496832; c=relaxed/simple;
	bh=+0ix+E8GBUCgIN6jbrba74DKgOITHGZNkoqWjOpimuI=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=uvrSmubc+546i7hVUkyVoAkFc89we9idE141ZhkOvqcMfO1ahywFS6xe7Vt+pXNJUoMNvl5qUD30j8jpViHgXr5POvwLDPddPLywQXK9gGunuvE2gr3Ey40JQixRDBnY4lGmybVUDOh5VQZTFBeuZw1z+CbazK8FwMRfSUm+EVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RsvnOQkY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RsvnOQkY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBE99C19424;
	Thu, 26 Mar 2026 03:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774496832;
	bh=+0ix+E8GBUCgIN6jbrba74DKgOITHGZNkoqWjOpimuI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RsvnOQkYaB/xQGi84fAXOSgcv8C+mjZoo+Zb2QqBkyrn28U4dx8RvVGIJg4Kv/4j+
	 BO8aOZKSUWH01fWSvI9Yl4A9oXTCbc52tvFyyZGG8WnGPzYWkHnNKTdJe/XVE6XOHC
	 ALYbltTdXA3IXShPr+TVzxT084RIn/h+vji4nNxl/EX5XpuJ2PYWyyXAB7T5LxLFDq
	 AOgUucSVylig283MIMvEacBX0jKEenjv2+hNGhrbE+NnHzJGMYENkBNOP/SA08AOf1
	 fES0AS6b/bkhztWRkK9+5C84GdUP7VSfEDFflyfqxcS4i5LChiJA4Mf9CAyFYZfMAl
	 RR4Bf97CabbJg==
Date: Wed, 25 Mar 2026 17:47:11 -1000
Message-ID: <f9c8d610c589701fe04263fda6236f67@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Zhao Mengmeng <zhaomzhao@126.com>
Cc: void@manifault.com, arighi@nvidia.com, changwoo@igalia.com,
 emil@etsalapatis.com, sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org, zhaomengmeng@kylinos.cn
Subject: Re: [PATCH] tools/sched_ext: scx_pair: fix pair_ctx indexing for
 CPU pairs
In-Reply-To: <20260326025155.94581-1-zhaomzhao@126.com>
References: <20260326025155.94581-1-zhaomzhao@126.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied to sched_ext/for-7.1.

Thanks.

--
tejun
