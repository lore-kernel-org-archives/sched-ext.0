Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767ED22F01
	for <sched-ext@lists.linux.dev>; Thu,  7 May 2026 00:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778113720; cv=none; b=LO1nX4R7BhJ+i20HSMzAAfoZzbLboeDEcxT7r7acw70wa4ZNVey2hzNVItNiMMzG+J3LWaxBV+I007MPSo8qKwOAzLsbCo8yxPSD90ybMx0RLdF7tsby3cji9LJxckAmIXXdnkFRV7hZ+p5IXqZJFggfDrz3gwAnEW/UhC44GBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778113720; c=relaxed/simple;
	bh=e2D9AKMXrs1/2QaPcsPmr9lAYfKfATHkGPoWtVNtvDI=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=EkiYmCFKTSTRZU1f0KrTi6qz949yUcutXYPkjvyF7z7P7EfIVy8DA8u6Gk7TqVeg7ggbmTthEX0UkVsF1RWQauQZH5dIZBWrl8mk+1TEXJyc0b4xBPSkfzqn8/olzLBBubKexGLLEmQ+y+HuKJAMp5ZgaXp466lJZGdyO/6nJsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=l2mdHQ8P; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="l2mdHQ8P"
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778113716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e2D9AKMXrs1/2QaPcsPmr9lAYfKfATHkGPoWtVNtvDI=;
	b=l2mdHQ8PtsMcW4jcrAtsKnCySJW5hlhXfoOricfn3uHZfJ2PI72cLtzN1LOzuOyox/Ljff
	7PXw5Qzef6zq/UgDSm09oA68WSMWSES1adPfKT9kSNbAUTVWt01G7Ys17HaxZoqaNVFty/
	MCtr4CuNRoJkwKYCKgmd4cRkMEfDA4c=
Date: Thu, 07 May 2026 00:28:31 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Zqiang" <qiang.zhang@linux.dev>
Message-ID: <0ebaf244d3b16d36f36587f8936e1ecaa1194b07@linux.dev>
TLS-Required: No
Subject: Re: [PATCH] sched_ext: Remove redundant rcu_read_lock/unlock() in
 sysrq_handle_sched_ext_reset()
To: "Tejun Heo" <tj@kernel.org>
Cc: "David Vernet" <void@manifault.com>, "Andrea Righi" <arighi@nvidia.com>,
 "Changwoo Min" <changwoo@igalia.com>, "Cheng-Yang Chou"
 <yphbchou0911@gmail.com>, sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org
In-Reply-To: <20d4ea38932499d7fe3379d1410cbbf2@kernel.org>
References: <20260430084543.25137-1-qiang.zhang@linux.dev>
 <20d4ea38932499d7fe3379d1410cbbf2@kernel.org>
X-Migadu-Flow: FLOW_OUT

>=20
>=20Hello,
>=20
>=20Applied to sched_ext/for-7.2 with Andrea's suggested commit message
> rewording and both Reviewed-by tags.

Thanks both (Andrea's suggested commit and Cheng-Yang Chou's review) and =
tejun.

Thanks
Zqiang

>=20
>=20Thanks.
>=20
> --
> tejun
>
