Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E30433CE8A;
	Thu,  9 Jul 2026 22:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783637398; cv=none; b=UQZiLXwdTAVQ12YGRFU7Os/nx9/jqQy4v11wDnsZGqu7PK3kJEmb/rxdnxoIXQjZWExExGxGm+Xxa7awxoHj9yc+Y8RQdPukODkGlXZIc1OeU+upVPLBzVrNcRw9TuT58ZBSoAdGS6gUIn8PHhpL9ClXhZZVYzHsv5yI+MB1NN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783637398; c=relaxed/simple;
	bh=+Z+yREMRg36/nFVLMWAZ++Aalg4hpSfpxAU4qSrcnaQ=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=gvWYReqDuKLotxLyqeZndWYcOw0NzdnqTM1cCiiXkNNukKUpF+LEzgCbOxaRlh91RER7LJeJw4kLCdPWxABSfWa6tH/90lVaJ4UOd15gBtMlJYXTKdZo1NKISqyoEZ1gsBHTa9rNvygJgCPNqkVF0jmhbMljSuwxrCYuLtYxNaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qlj5qFy6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qlj5qFy6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35A891F00A3D;
	Thu,  9 Jul 2026 22:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783637397;
	bh=+Z+yREMRg36/nFVLMWAZ++Aalg4hpSfpxAU4qSrcnaQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Qlj5qFy6IsouHv9629WM596JOjN3uPPZxy9Fh4bInmlfB1QuHrzxapxPYFgPGSKXl
	 ia1k+pD5J73BCANG8rDVECIVW6f9VKenkTkOhmhjFyLaY/N4VDsoeQ3Ls6rUiJJiIm
	 TgdJjJSdxGftHWQhEX7o5i45fdCNZ41GagYEKron1xdIEjc2HODAdSChE205UxXXfS
	 bqIIqNGn9QNwzcfsksZyltLntlCjEnB7KT+4QCwstsenkCGtLo8HmsjfMcplx7SO0w
	 qAwYhXCok26PS3noDMB9Q1yBD/1lxuheLof//Gnhgv/vvbdTueCPDeW3T6A2bE8VBJ
	 6E8u3rmtVgvyA==
Date: Thu, 09 Jul 2026 12:49:56 -1000
Message-ID: <fdd7c50562be16248ce58e006e9a3e55@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.3] sched_ext: Keep rq tracking accurate in the consume path
In-Reply-To: <20260709051708.306636-1-arighi@nvidia.com>
References: <20260709051708.306636-1-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

Applied to sched_ext/for-7.3.

Thanks.

--
tejun
