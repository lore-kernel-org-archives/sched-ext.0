Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0326834AB03;
	Sun, 31 May 2026 18:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780250896; cv=none; b=GIhK0jyEiVKGmyhz+UkAv748hJWiRajCarlKgjzdbGoQrFwPHGGDn0zyqDc+O0naIRhOhvioH8rm00idiRVQwaxznriZ3v3dcE5UG+vec+ptblCw7NEl4tSAROaOLQvcxMZCM77BAjnytR5QoE3Ihhklm4FEbaLwoUT9zRd1DSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780250896; c=relaxed/simple;
	bh=CJG5A9B38jiEfMGdCzy3BwA7Lpi2SzZyxFe4UANZtgQ=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=nDbWtLgo3kREj7G+z2G4f+5kLLprmysyWyPGZT3LTv2lTcvdjo+h0Dk5+EE942sDxCrI/3UxJnNqj4as8P+x+Sowl4SmH1XAMQtqf7+S+USihfx1EY7UyVa614HdiEk1oZNlhASVfb0KdKVVwg/y8WuS2glQewoZcMBGoZwAIaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XTyX7jY5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XTyX7jY5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62FEC1F00893;
	Sun, 31 May 2026 18:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780250895;
	bh=CJG5A9B38jiEfMGdCzy3BwA7Lpi2SzZyxFe4UANZtgQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=XTyX7jY5D+UncoZq8WGdeN+B1rc5i+v9gXUdyg/etverS8mxPWH0B5MrgE9tkvyEZ
	 IpN8bVkSWuyfi0UdJixzzE78vvm+U7ZvXBJEnIXDb9BwtPnn9kqX1qntLrnyIG495y
	 c4D99DNAj7EVuibybJ8AovTE+ZC5tSVuJ+tBIqAsF0Jveu696qinRQ8FTT/M/nC/m2
	 PZ/etdyVWZ/HfKnkeuHqPLbfVk3JRNDBB2BhY2lML4Y/yRGyS3TQx7KYp51jnXsquw
	 7jGUDIrQH8/w+TDIl4BIZsye7dbwwPblYjKxw6o/Iw2ki0Gdwfb3narFL8Ed6Kau7P
	 qzOhHNLtC2bow==
Date: Sun, 31 May 2026 08:08:14 -1000
Message-ID: <93c405c4cc769c676a702a1530aa4ff0@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.2] sched_ext: Guard BPF arena helper calls to fix 32-bit build
In-Reply-To: <e8d28ed3e35f72b7dc647a6ef27e1b80@kernel.org>
References: <e8d28ed3e35f72b7dc647a6ef27e1b80@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied to sched_ext/for-7.2.

Thanks.
--
tejun
