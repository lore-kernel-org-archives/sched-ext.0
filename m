Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1173DC4A4;
	Tue, 14 Jul 2026 22:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784066988; cv=none; b=m9bILUVT4c4qSNyQPia+fHlZrXcqkB6so6EUW0F+VAOicb8FRSoG8HTO5eWCIeOwa8nS5L/Qt8yvzBG1KOREzKkIqIyBK7v7rdlOKRUgFeptdwq0lXSMSCX4ean4uO2xTO6SF5flyXJqzVJwtYDchGYNFuxRTuvw/NbjnFhZ+4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784066988; c=relaxed/simple;
	bh=uVpvbpodR1Qv8XeEb5xkjhttW8Idi3LgIdae55CNh9Y=;
	h=Date:Message-ID:To:Cc:From:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VMbpmrKatKLb6r37QWxroClaHNrvOcVgrXMZHrKUe9TuXHxCr60ZTEA+SPHwY2MA5VDQaeI1816qneVU5emoWNm5Qzq0FmyDi3lyErsPrxNc9rfNEjf5YlE790+ovq5vkF3kjKYRoDo/uO0j7VmXIXPj0aJHcZOi7eDO1rZ/c/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eI/ui5oM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eI/ui5oM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB2E51F000E9;
	Tue, 14 Jul 2026 22:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784066987;
	bh=sCWfCW/WHaS4hQ0x08P5dfuJOMP/omwj0h/vxEDGcZw=;
	h=Date:To:Cc:From:Subject:In-Reply-To:References;
	b=eI/ui5oMLWnaUvUylglBK4KJ/WkE2IZyCRtgtfM3hqPa5xYZjo0t10/3pp/FAE5+P
	 2magLK/wTVQvdRRH5uutUFGARukCNSvfg6TufkINuT6bl/tTVuLPzSAJoNfSagxKHC
	 GW+Sc2ieZGWZ2YzxMs0sft5UhwFMCqBQVp4Q3+VXgm1kD7bsA640LjxQkzoNqSMmuv
	 P4xhbM3DIjd9XM38WjvKLi2Bxz8sZP6znf+PJZT13GASiVzHIVetKW6N4zxqeGWtv8
	 QyECr3UHRLPZt1/7wPuapm0L5Zlj/C/9ylu9S3+XFEBCcKc/fNJAUAG9sXA/Vl6nPr
	 7c3P431sJSO1A==
Date: Tue, 14 Jul 2026 12:09:46 -1000
Message-ID: <1a2b2dcb03983fe95f672acbd7486f84@kernel.org>
To: Liang Luo <luoliang@kylinos.cn>
Cc: David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>,
 sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org
From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] tools/sched_ext: scx_qmap: Fix stale API name in comment
In-Reply-To: <20260714032051.1834822-1-luoliang@kylinos.cn>
References: <20260714032051.1834822-1-luoliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

Hello, Liang.

Applied to sched_ext/for-7.3.

Thanks.

-- 
tejun
