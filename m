Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40743D6487;
	Sat, 17 Oct 2026 18:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792262696; cv=none; b=C45hxOyrrhN19je0lKLis0h2oHXhpSmRo87y/SnUeSAB2inD3pWI4QT2amMn7nWNzXeFqs0l7nyPIQoafGF1N0rvlYNdnMvOOJl6pU6v2LK55dEvSlneOSQ+hXnrkT8mE8UZpUkIS8Xa2cO9trSREh6ZJbJ4J+UdQ0fv0eLgAg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792262696; c=relaxed/simple;
	bh=6Y7vYf/xc/TsRZfeinhAcNhu9VUF65Y4YoGWlsYueBI=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=jsuXOG/J6OeVbYoMIawgPRX7yG0vqwi23z9X6qaCd8aN+j4uphWCiHt8B7jYbM1TlAMqPBwMwikZdRknE6Edbm43oU14Ed5SUDULAnCoc1mbt/AptZMauy6kjI5cHauBrT9RPWBsKJGAwY2/VvICIk17X8ErlVa3NiskwArBltM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DQLs+Kyt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DQLs+Kyt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 376D71F000C4;
	Sat, 17 Oct 2026 18:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792262695;
	bh=6Y7vYf/xc/TsRZfeinhAcNhu9VUF65Y4YoGWlsYueBI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=DQLs+KytNtJSGRRtUosT+uXFw1RcS/lNaRmT4MXAW0p/isLNN3Y2nZ+fn79KPxy+p
	 PK7NYbP4kCSq7NlAsOVLAhEK4ee/x9geKxtaMs8uMgbe0yHJDLr3PvymuwnRMvJP/t
	 yxzkFx5licLt1ops+XpIXY7UhxgITe1VuteXXxQI5HFaJar++y1Mvv2rH4lB1WA0Ut
	 /UN5mW76kZ+drkfud2Fvo58j/EnfAYzzvDAXvadH17xBb/oE74cMDqJNKUtSYs//9I
	 a58VM7mBTlzI6/asqDBVkhBxBm7DvOxgZ3sy5UkNjvkWIw3O3cbTBbcY/qsS7TK08f
	 NXA6t1UCPfw6w==
Date: Sat, 17 Oct 2026 08:44:54 -1000
Message-ID: <fac1671153b59deddb9847f2c5d946e1@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 sched_ext/for-7.3-fixes] sched_ext: Don't leave balance callbacks queued across a pick retry
In-Reply-To: <20261017152226.3690249-1-arighi@nvidia.com>
References: <20261017152226.3690249-1-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied to sched_ext/for-7.3-fixes.

Thanks.

--
tejun
