Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5D2397950;
	Wed,  9 Sep 2026 18:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788977210; cv=none; b=eAvP9f7wyR7hyw1CJr1ThQITPGdWtY79kF/fruJ5kTRgB8k9HalfVTQcv7Wc2TCCJLYO6/PHQXAsNvUAuYsqumjzN+x+8VjtgqwxowlP+yRAZSz8TziyK4gLkvFT6g5pPW3zTdxPrWJ2GSzzT/8+0K+TzbYiwbLaOz/eP3857lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788977210; c=relaxed/simple;
	bh=WhHwf3Ka9Vf1q1walvuzaPCFqfmh1Pk/QqL+ux/sqS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j+AwDgX/H0Ai37j/7Mvbh/Oi/MFe8bAq6ITQElgqRP1yfvsYMRtiXF+P5dgvOusj0/a23cycwMq5yW/aEreudN1Xal/7bG2uJEuoV5dJ2LxbECg+jgdf29XKMcez9MOw0RKF4+MbSTyqXLlczOU0MQm9dcefKzDxEgzon4SEPWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cj6liFwD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cj6liFwD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 028951F000FF;
	Wed,  9 Sep 2026 18:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788977209;
	bh=LvHxWR4ioQbnIzdZ8OczcxC6IlozkFwifw0VvgYRDwI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cj6liFwDSgwFiS6egbYG2SAyGAMoRKapA/nFKUly7dvzr++UApVvH4fm015huwTgP
	 37LQqghYmttj/zEnDkdXqbBOc6Rhxk/1deB4zsa/HdWPS2/MxXk0Q7XxiV1n0RV49h
	 XvCcsrYZgVHZspp/ehfsMJz/gouDswJvvcKi1N+AEKdA81awP/OrdfUwzrWUXRflPa
	 89+3N0p1+USYSChdJhJkc+trYXgddHnzqsMJ+M8/o0lEwRAHwIXEqAigNoNPdwlkj3
	 COcf6ydEhiOZLYCbvA6Aixch9oviTgrzIxWH9Nh0017qF5gOtRGIRe0TAFzPvK/uyy
	 zQBzjd7PytS7g==
From: Tejun Heo <tj@kernel.org>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
Cc: sched-ext@lists.linux.dev, David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>,
 Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
 Chia-Ping Tsai <chia7712@gmail.com>, chengyang.chou@mediatek.com,
 Emil Tsalapatis <emil@etsalapatis.com>, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH sched_ext/for-7.4] sched_ext: Merge adjacent ifdefs in ext.h
Date: Wed, 09 Sep 2026 17:52:35 +0000
Message-ID: <178897635522.2.2211845744379646092@kernel.org>
In-Reply-To: <20260909172740.36375-1-yphbchou0911@gmail.com>
References: <20260909172740.36375-1-yphbchou0911@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hello,

Applied to sched_ext/for-7.4.

Thanks.

-- 
tejun
