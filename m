Received: from devianza.investici.org (devianza.investici.org [198.167.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BF240800D;
	Sat, 15 Aug 2026 12:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.167.222.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786797237; cv=none; b=Ajgui4WqROIfRId/XQ/tAih7iRffUerc/qIZxIR8yDS6aQPWNpNTtpLDx9b/s8EXb+gXSSSWzf5IDVdettrxTvM7FSQbXidY/oZ9QUUomcjbt6Ml3EfTPa62XinHsgo+WEkH9TaaO8Drx9+VpbFLe1+mdB/SCFyqTKnTcVGTUm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786797237; c=relaxed/simple;
	bh=JcX6WketrhPof5FVd2Bs9n3sGReE+lBTE1XuWP8kb/M=;
	h=Date:From:To:CC:Subject:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=r/Q++aVHEsFSP3D4J1PaPrC3/omP0UcPO6yydIRJZeCcIGjriRTj0d7nXCVh+5AoHCfJZc+pKO9jzY5P4bp1CoZmg5TAy7cg8Nmf5eKLzq9LeJ7KjfO2Q6tHz3GFWgjXEyi4jgnYrflPJhTLWECjy8Ey6nMxc9dKLZF/R6hR8/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=KbfXbZHe; arc=none smtp.client-ip=198.167.222.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grrlz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b="KbfXbZHe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1786797225;
	bh=QsAWcGqOMLKUKsdA0BRaBoF1kXhD1ylcA5tRJHcX1h8=;
	h=Date:From:To:CC:Subject:In-Reply-To:From;
	b=KbfXbZHemPNUBj/hgRUaZ3zQGoB6xQdCPz7xSSaknm6BKSJbuBte4c7tiOT7lQgO8
	 62LBUl5Wuxh4Of0abtB0BVa2xzU4GImDxTZf/h1b66BxDQ85csTACvs+Nmv0R6mjuQ
	 klDDXxoSNTKyF8p6vZgRdcff9Id5zaPX3mpzEOZU=
Received: from mx2.investici.org (unknown [127.0.0.1])
	by devianza.investici.org (Postfix) with ESMTP id 4hMdn52hXNz6vKp;
	Sat, 15 Aug 2026 12:33:45 +0000 (UTC)
Received: by mx2.investici.org (Postfix) id 4hMdn46Vtpz4y6W;
	Sat, 15 Aug 2026 12:33:44 +0000 (UTC)
Date: Sat, 15 Aug 2026 13:33:46 +0100
From: Bradley Morgan <include@grrlz.net>
To: tj@kernel.org
CC: arighi@nvidia.com, changwoo@igalia.com, emil@etsalapatis.com,
 linux-kernel@vger.kernel.org, lkp@intel.com, oe-kbuild-all@lists.linux.dev,
 sched-ext@lists.linux.dev, void@manifault.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_sched=5Fext/for-7=2E3=5D_sched=5Fext=3A_Ma?=
 =?US-ASCII?Q?ke_SCHED=5FCLASS=5FEXT_select_GENERIC=5FALLOCATOR?=
In-Reply-To: <34c6e5eb01c406d93c8845b94a990069@kernel.org>
Message-ID: <D5411BD0-A9DA-47D8-A951-6299A3ACD919@grrlz.net>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

Don't kick yourself in the face too hard because you applied it, but since
this is in base kernel/, and I understand it, I'll review it! :)


>build_policy.o: undefined 
>reference to `gen_pool_create'
>build_policy.o: undefined >reference to >`gen_pool_for_each_chunk'
>build_policy.o: undefined >reference to `gen_pool_destroy'

gnarly! But, why adapt to "hppa"? Its literally been "fully" retired since
2021!


Someone in the kernel, no idea who, said "Why need to adapt to these old
architectures? Why can't they just fork it and fix it OOT?"


But that's more an opinion thing, in my opinion it should just be OOT, but
the people who work on hppa will be pissed.


Heh. Just know that was a small rant, anyway, good patch 

Reviewed-by: Bradley Morgan <include@grrlz.net>

Thanks!
