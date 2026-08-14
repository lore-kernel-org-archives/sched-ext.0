Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDF93A450C
	for <sched-ext@lists.linux.dev>; Fri, 14 Aug 2026 22:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786746638; cv=none; b=VImCWS6wKiLbxkS3krhCz96ZsNz1k1tEKH9s1os3Hwv3ucfiEfGW1Y5U9OBYbdaJr+cM1PIdYM9rZxf4cJi4eKRVCTeZBlLbnkX+xMeRKUyySZqTZwnDWz6+0KmpmFsD33kG6C75ONQWd+izTebgsO3XJbbv0Z/lf5o0urvZzNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786746638; c=relaxed/simple;
	bh=wA7J02LuqMgPuA8fcVZySJEa9aIl3kxsyMPtkxsd2EY=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=JqKlYwz5OWu8TXGKIJKk1E15mly3nv8XyOwihgi/Nt6ZNSRmk9VzDB90X+YdjUFSONVZz+GZEOku0GrtCJTbNofSooqCDsCfUPEXO2mcoASew4iqYgJj4qQLL+RPqFl9xTGhPa9gJt9GQlfwIlIUZa/JLsDjSFBEXZJlBvNSnLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xq4isn/Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xq4isn/Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A40D1F000E9;
	Fri, 14 Aug 2026 22:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786746636;
	bh=+Z+yREMRg36/nFVLMWAZ++Aalg4hpSfpxAU4qSrcnaQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Xq4isn/Yk/Qcg1sev+vmWkuc79oWJSwSnpvJUo/Bq8y+/zmXJXtLVDZuyKk215YWa
	 cuIALKcsMCyJ7XGIs9EAN7IiClTUk3lIughBkqqhxEkfnHZNnwbR4YVHX7MEygpiyO
	 WThX0fBay3izZ2r6odv4WGnMBUgJxb1O/vv+8kXQqZO8KDBx5MG9tlmPrCFiNyOeF5
	 i4kMw+w1a1N5FN1F32jrfYyNuQgdhaicl1rYK/nuteRenxktron+anTiB1bpZvseIG
	 T080Yz/St3r/xvYEVoUfjTKe66Wb6VmfQVhMlka84KKqlTnlf/oI2P7LkJ+xCNPIKN
	 PvlKVxBdnCAWg==
Date: Fri, 14 Aug 2026 12:30:35 -1000
Message-ID: <acc89c8d6db9e09ca91a4cf8c0534a5b@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
Cc: sched-ext@lists.linux.dev, David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>,
 Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
 Chia-Ping Tsai <chia7712@gmail.com>, chengyang.chou@mediatek.com
Subject: Re: [PATCH sched_ext/for-7.3] selftests/sched_ext: Make numa idle
 validation race-free
In-Reply-To: <20260811153524.6616-1-yphbchou0911@gmail.com>
References: <20260811153524.6616-1-yphbchou0911@gmail.com>
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
