Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8595F37DE9F;
	Sun,  6 Sep 2026 22:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788734988; cv=none; b=cH0+tEq+oCasLHlMMbt7dJd1yRpGRFx0vSfVNbDQYSamMKR2NpTDQA3+g7eOdzNiWmcdXGfu8zRhku3XuXmSy8mRYmritSgO1os7zxTG3caQ4Fw8bp9MgNYyfkhCUxQI7THZXPOAMU8icggDsLBI6NU6qr7fhPpL5Uf4DmLI6vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788734988; c=relaxed/simple;
	bh=QgwHzUyrQUAWa+jzuyQUEhQ+QqYKBvFuu1JXeyhXpyA=;
	h=From:Date:Message-ID:To:Cc:Subject:In-Reply-To:References; b=epHXOwcLvWo0lcB4i7MsVXjuMS1J//XjfAGN0XAYbMV5Jv3+tGTBkJ1kt+Pk1uBBTbaQ50CD547Mv1vSo7osNp4HQVhBTQn+QnN+pHEPAfQ2Hm8hHjCXrv3oAFaQMnFy8oOcJ+MRL/UXryZuYhEAH+OMvRJUADHNDY+xM8aAW10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A5nh8xla; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A5nh8xla"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D48C41F00A3A;
	Sun,  6 Sep 2026 22:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788734987;
	bh=tN9to5j8LWH2RsDvZzU6SMF81vzjyLp0pI2fDrTXf2s=;
	h=From:Date:To:Cc:Subject:In-Reply-To:References;
	b=A5nh8xla1V8LL5BoDCvL5o6O+i0VVyu051tNxlJic/dkaRk67eIOVsJmZhvt+JQmj
	 yEldt4EejmZVWMQNcScPwRD3LL3afmgEGzhObTgg+AQj6bTfbPwd0m5HQoboZqsHsj
	 NHowm2g2No+0xgeYUHEQlOr6cXLcxlAkFhGoTMoXPjDoV7USyF1Pf6RtkybsaEieva
	 LVDdFrL+B1EIf4AVWXBDnPGkDKKBVi2Bi6PUaYbPlfz0udYbmSwaTvPXOsMAnk5IBa
	 MHIJmbCfAieoXkt9vRXgSe2YtU+64AHmIXbmfpbUtQ6XBVH6dfQRSAqYTmQwO89GnY
	 JdNNiXPf2TzhQ==
From: Tejun Heo <tj@kernel.org>
Date: Sun, 06 Sep 2026 12:40:13 -1000
Message-ID: <e08c5ec58b464ec684698bc59b864aeb@kernel.org>
To: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev, Emil Tsalapatis <emil@etsalapatis.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.3-fixes] sched_ext: scx_qmap:
 Fix pending partition work handoff
In-Reply-To: <4c9a9c9cabc3547e23bae5ae00421a52@kernel.org>
References: <4c9a9c9cabc3547e23bae5ae00421a52@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

Applied to sched_ext/for-7.3-fixes with Andrea's Reviewed-by.

Thanks.

-- 
tejun
