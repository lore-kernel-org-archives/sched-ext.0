Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31DB37AA7A;
	Sat, 18 Jul 2026 07:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784360458; cv=none; b=eln5mLg+aQnMfjmLS0ghGjvuukXYfU/v9OGo7q1KQohgb1NaAGPiDTYEhW3Y81SSB3qp9cYc01bZ3qd6AOlwUDB19mmoniam1OeneOuOffdvCCqYkCqO26loEZulIS4kDF13B1BVVWR6unkoBIL+7mAVZKZZRknsjPlPQsoCLSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784360458; c=relaxed/simple;
	bh=4blmnlSclCUE0CYWnRAj6q/ipwOGmYZsKXke79wXaTE=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=j26up0O9C1BDtq9T/mZ7dNF6pietaYr5nHHQPHlipqx2RgzvwcjTflWKKiexNhvq1t/gupEwBDXSHtCnH40O9y4Y+5gOLJv5IAHp9UWLXfdeBBxYG9iSxjPRkIEk9D9oO0lU1/irm9lxVDIrqrRvxEGA/iiTYrGFZB69RF/wkrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A9Q53JDB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A9Q53JDB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ABBD1F000E9;
	Sat, 18 Jul 2026 07:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784360457;
	bh=4blmnlSclCUE0CYWnRAj6q/ipwOGmYZsKXke79wXaTE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=A9Q53JDBuwsVLNOPCf40IOHeZvesrqQdVqc1n6zTDuegaFmCQ9RipdLbuG22m9cHg
	 Li5av6fw4t/1nAQY779t443ogNVdgM3qqDruDRR+yEjsibX3nQA9cEnKlAxRwtWap3
	 0M9ZJU+QnSwwMvD/FYZG8+dbxdkqLN4GmEBRUvzHGmc9gyx90bFZH1mmLYn+S763Sa
	 D2meWaQowJM8Tx/fZ83vvRir9vmmWSCPZZzejf1Jdkikk3pLvrMxmQm+PEBNTACTSg
	 IaMlQQH5aqIsC7+1+GT+ogiwKf/7GMT+Nt1eCk6Sg23CIxa9FaUVcv8sbERB1dYf77
	 nuoMDza0/T81A==
Date: Fri, 17 Jul 2026 21:40:56 -1000
Message-ID: <c7ace2a59a269b6d5f526e5cd241a2df@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET sched_ext/for-7.2-fixes] sched_ext: Assorted
 sub-scheduler and cgroup fixes
In-Reply-To: <20260716213058.1739522-1-tj@kernel.org>
References: <20260716213058.1739522-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

Applied 1-4 to sched_ext/for-7.2-fixes with Andrea's Reviewed-by added.

Thanks.

--
tejun
