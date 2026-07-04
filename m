Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607D91C84AB
	for <sched-ext@lists.linux.dev>; Sat,  4 Jul 2026 00:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783126476; cv=none; b=nJBkrSkrgNADVQcLsrSwHEi0DwxE+PMj7qpdboOS9I9eY5BMMe6UsiEE3KH0Xx/wFxq9eOqClNeh5q5Ui1SV1Z53Zbd0sdABvvP3KOTsVrbionvqHigT0156kR9LDjuclAkvLouelqkv2dQC5x4Tr9ujX4WVT/sTGFjG6D+/EYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783126476; c=relaxed/simple;
	bh=o2sYhrX9Wj3OHbqTlFlm3DrSxzhtgclW+OWbJyJ6EfI=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=fA/tpiJJPv9BlmQbTDCxRkW8FEylENp4fo0zjtmPm9RaDTEqYgbDy/T0SdhSanr1YHx2kUG2v+cA2uh0J4KFltm/QA4mZDRrrVwudEGollSz5GoRcUyi3InpGygySvk/idx37PWobOeGq+Mu5+xaO67gaWEZQXEZH/1xNbHxWBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ejUuxgxK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ejUuxgxK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 129A91F000E9;
	Sat,  4 Jul 2026 00:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783126475;
	bh=o2sYhrX9Wj3OHbqTlFlm3DrSxzhtgclW+OWbJyJ6EfI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ejUuxgxKdYavCGEvFhHq7Q6V85fn9oIVNCuqSQIqECTRpSmWI5TBnMFYcOYrYjjak
	 RwgDIea6Iw0VS4Op3vm0+jMGjIgkc2JQM/IcsJzTC77UJmOslc2342NW9bnqwPsjHO
	 H0C7RuKBXqQ13c1DfMpCHryowIhxZn0WwfFU2jeKkDQsrMuP7oX5FeGwIHKW8SjoTy
	 NYSRyjDyr1X38NtAb4D85f96lYK4CG2rm5lFOUl8Os966Je6pRH8eCeagJPVHd7rxU
	 Y2YmO8Yp7RhY2Hg24NMBHL/NEjNM4fBo98fe6Svab5YHyCRSz42rxDbmGqTvFpQlBO
	 POCRt4rU0u+Dg==
Date: Fri, 03 Jul 2026 14:54:34 -1000
Message-ID: <ab4815348fb99a6fcee269f4c2cc3a79@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: sashiko-bot@kernel.org
Cc: sched-ext@lists.linux.dev
Subject: Re: [PATCH sched_ext/for-7.3 28/32] sched_ext: Route ops.update_idle() to sub-schedulers and re-notify owed scheds
In-Reply-To: <20260703141432.7C56F1F000E9@smtp.kernel.org>
References: <20260703080159.2314350-1-tj@kernel.org> <20260703080159.2314350-29-tj@kernel.org> <20260703141432.7C56F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

> [High] Double delivery of `ops.update_idle(..., true)` to BPF
> schedulers during an idle transition if a forced re-notify is pending.

This only happens when a forced renotify coincides with a real
running->idle transition. v2 will suppress the forced delivery when the
CPU is transitioning (the real notify follows), delivering only in the
already-idle case.

Thanks.
