Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A264EFFD2;
	Wed, 23 Sep 2026 18:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790188166; cv=none; b=Gv4ICtBb0pDa0PHBMzWyaIjAOtlzOpINvIKeB5flWAldlq8Ux4SZQZ13kwO4mL1nkDUA6GAR2iHV2n/uY+UEMGL33YHgnp1TIChHjeioTy1LVUnPfoZ+7Gp/c8QUBwFDve3nxjFFH5/TJD+Wn9KdfHPO9ryRgqE1A/Df+xIGis0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790188166; c=relaxed/simple;
	bh=6Y7vYf/xc/TsRZfeinhAcNhu9VUF65Y4YoGWlsYueBI=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=txaPS5RlYXda+Vxhg8eQUX9fel/tJhLAWZ9OtgG3BO/fj1XTofnskpICCnAJYyvthjNYJiYh5kZB9pdF2WFI33QNyw3F9mPoPkS/T05m+Z+0JApO/No17ZUd9VsGfr3N/Gidbv33GR/QkvsaCVwLPDwN5aaJtZsIqMkdhDVRbXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AfkA0Jq2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AfkA0Jq2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50F5F1F00898;
	Wed, 23 Sep 2026 18:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790188162;
	bh=6Y7vYf/xc/TsRZfeinhAcNhu9VUF65Y4YoGWlsYueBI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=AfkA0Jq22eKfJP5pnbGyAoE47t8alxzPsfg/uCXowbDWkVeccx+LQYdumngCoNEio
	 RQKhyvffOqRgIWAjUnuCJZ6lFEPg3AHQK4ReQw5x/qRMCoSCOZDIq3wQcRzvv8Y1LN
	 mh97tuWXyQinI2Fg4X8Tp/4iaU9UZuPeMH62K6oktPPTyrcIvfkKgc/bHmE5GprxxU
	 FEfQcL9gjbrg3gCIj2gg0GFJmdKOsWPYsE2ua4vKb8Y5xOflPGu5S8LpNZINjYFIGf
	 b1Mp6K132z973VPQJTAYi3rPnvlIPWbvMHjjkSgrV6rpAOnPIpqOmqzXJwz2zs3JNw
	 W2JPS+MzrcKgw==
Date: Wed, 23 Sep 2026 08:29:21 -1000
Message-ID: <3dcc76d9be682c3266e5531efe8884a0@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Liang Luo <luoliang@kylinos.cn>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Count SCX_EV_SUB_BYPASS_DISPATCH in the
 dispatch fallback
In-Reply-To: <20260923110737.2170928-1-luoliang@kylinos.cn>
References: <20260923110737.2170928-1-luoliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied to sched_ext/for-7.3-fixes.

Thanks.

--
tejun
