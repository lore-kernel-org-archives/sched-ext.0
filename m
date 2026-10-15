Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E68839E18F;
	Thu, 15 Oct 2026 19:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792091557; cv=none; b=U28DYlEydW0zH2RzkmzoWuZnwxZb3FAguLco0ByQhR6hlbcxFfSCAFclbuK8+1PL2x+KZAdrPNEOxb4lBXoKFEN90sPzQi8WtGCOJKdNuBSXTQY/GED8Y2PA4SPPrbJTGbN2lIWkh39H6JJktBGO4xf0qvZf0fabMJHH5SsnuJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792091557; c=relaxed/simple;
	bh=6Y7vYf/xc/TsRZfeinhAcNhu9VUF65Y4YoGWlsYueBI=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=p3ShxQPtNZ2oFGHCauVZ7nhVQhJbbvk9qIEV316DhwIGqn9/4fxlIHouyeZK4lDI9AtBrJqCRsOI8LDbqxvxhOC3onqRDWvxJCgL9ys2NFi1AL+rTdtBdPc7WAEhLmV09yR1vRrQdv3dR/IdPJYS5QSn1vV8DRUXEyMOcQnks5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kD6+CPzz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kD6+CPzz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D6431F000C4;
	Thu, 15 Oct 2026 19:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792091555;
	bh=6Y7vYf/xc/TsRZfeinhAcNhu9VUF65Y4YoGWlsYueBI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=kD6+CPzzzdW6Hoe470mlcJ0ot4mHG3ABgYaBr37JEb80GJnckQt+skL6YbJCdLxx7
	 RygcwvsUX3Z7Ka9FWjw2FflQbB9jEHJNoOTE/+Wg4Fwsfw6s/yW9IZ0Vzxo4dtZA77
	 Ow3fGoVBmJsvxyZdD0j+01emUmkEPRIqPlOnOZoFiTKlEJ7MVs018QPuJmMtRowcgx
	 uib3X9yyAGdZg0gZKRtNixpm/FD759pZclX8urRRtbxjbxVwgbScr7yIu1Rmlp0N0n
	 w4T7j+Y/xA1unJ/fHBH6cw3C8n7qSpRaabao+HaVuw+GmfagynG91Kw/rGdcPja+xq
	 XoXwYyWUJX1Tg==
Date: Thu, 15 Oct 2026 09:12:34 -1000
Message-ID: <fe04ef6d5162a7c40e2a7cb1581167f3@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>, David Vernet <void@manifault.com>,
 Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>, David Dai <david.dai@linux.dev>,
 sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.3-fixes] sched_ext: Fix use-after-free of a local reenq node left on an inactive cpu
In-Reply-To: <20261015171628.714661316-1-tj@kernel.org>
References: <20261015171628.714661316-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied to sched_ext/for-7.3-fixes.

Thanks.

--
tejun
