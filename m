Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FB124BD03;
	Thu,  9 Jul 2026 21:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783631907; cv=none; b=BZ4S80M+opeZZV/VHGtp3kU6xAZfFrPBcdm80H0F1dOBY/orGV+yO/cUupNp8Nrund2cJXbEWHjOW3/n53/Ep1UYHfuGek8E29BByEhVwHEhuD0ammWzX7HvGYvRrxCJ6ugt19MIcgO8cBOBJH8gmhMzkLT/gQtE892bcwBtlkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783631907; c=relaxed/simple;
	bh=8DYnwgD4x2G+4l82q8gbPEaM16tweZkuJrnUWkmXx6Y=;
	h=Date:Message-ID:From:To:Cc:In-Reply-To:References:Subject; b=RAUgkMfCPclRhRkE0yUzKHN9G8NiLLIzeDDdrA8dC4VNFHZHy8X89ksU1bngt0A223aaXopdoGPIULRVzmx/vr8IAzUWFmzHGx9KwtOmeGSw7Y4tZ4Hl5EiMJR6F+dxmUn2m11I3+NDa0+1wCdCxfwhpB9M5onHVMryx+nxySX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VfPXWu7M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VfPXWu7M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E2991F000E9;
	Thu,  9 Jul 2026 21:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783631906;
	bh=8DYnwgD4x2G+4l82q8gbPEaM16tweZkuJrnUWkmXx6Y=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=VfPXWu7MoLONrRDEmLlz9ySgObxv3mfH1VuEAg2WsN8Hu5wRCFGhXaEqHbrGJ0qbC
	 CuLL2EZ/2EjXC+IEL0yxtXYNPccEYAdNnH7Z9b9DA64DuRsh+mr6kOfD95+NMWUyNy
	 izG9HqmZ2t46gzJpm/c2s8u11emNe/nOgj1amhHXzkoNbemMuEq+6y4lCzB04Me4fl
	 ANaW/tH9RJDrZS1ACeFSN8nlSfmbQ6PGFk7HvskQbpeuY1VN3/GVlAyKke9fy8hEQL
	 1ZBhnZQlg5ob/strEdIlqk1xUhLiMtPtftXJlaTAmrrZCWDMA6o2AS+gPSqzXW5M0H
	 Fk965kvCAPc8Q==
Date: Thu, 09 Jul 2026 11:18:25 -1000
Message-ID: <b43dc845aee5ca33d51b2ab2d370fa9e@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev, Emil Tsalapatis <emil@etsalapatis.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20260708212429.3405787-1-tj@kernel.org>
References: <20260708212429.3405787-1-tj@kernel.org>
Subject: Re: [PATCHSET v4 sched_ext/for-7.3] sched_ext: Capability-based CPU delegation for sub-schedulers
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied 1-3 to sched_ext/for-7.2-fixes with the contexts adjusted for the
pre-reorganization code layout. They will drop out of the next posting of
this series.

Thanks.

--
tejun
