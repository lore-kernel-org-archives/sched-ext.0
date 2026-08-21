Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50123F3273;
	Fri, 21 Aug 2026 19:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787339683; cv=none; b=JRgY9rIoxjlbPbkJ7HwXDy7VUch6o09T2MOwpdvGJhK2xE+CTkR/hkYfkfGyYZOx5dgn312KbL9ey8A17rwG0msXQyDPtF0adxvHim55wQDjStLH0ALlDww9MHosEBMcWIJwzV2YeNJRJ9AwGHWn0TA7KfxlqsWEGHl85YWnCA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787339683; c=relaxed/simple;
	bh=6Y7vYf/xc/TsRZfeinhAcNhu9VUF65Y4YoGWlsYueBI=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=DIKr0KsrblDZRNbgUbfvvEMJ0AJEXotCz0Gs12oa5aq/CNnNkKRGq0X9VWkN+vlMFxkICGoxGRVTxy++ZM1RebYIDYdDABFsIafa1cWm3BpoI4fbavJ45rbWPIYnJIZezT6JN2qq8SIdxeXMPPUiGs2xLWFmUDnpk5Q4HADAlRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=edqalSsj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="edqalSsj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCFEC1F00A3A;
	Fri, 21 Aug 2026 19:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787339676;
	bh=6Y7vYf/xc/TsRZfeinhAcNhu9VUF65Y4YoGWlsYueBI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=edqalSsjl6DGfcOZje+kW07SsGGndTklP6eACJaQl61//v+68myPZaoUpwX3UxO0A
	 Hm7r887nuoeW69pHvvIZcadEiHvRF13Vj9Om7VKnU9XbMP2sLgfSFEQ7MLRlA6xZ7r
	 P+LsaEGNDRGB8kS+X9YznNTu1i9uy6D8AZTSk7KQhLEPYBb1H9VkplVE0IsE/ftdHx
	 F8GFRqt8zHmia+9D9TpFGR3aWuF42t+a6DApbFDnMRIHDIhKF0NsmTD4UIgmrccKj8
	 iGfOivjc7kVPOzSfrXxYYDHoecNPJQhPp2jIwWcdDCW+8OET72sUL3y78u38Rv5blb
	 Tcdn18f+Z93Xg==
Date: Fri, 21 Aug 2026 09:14:35 -1000
Message-ID: <053cef7a5574785d5b3a0a70ae45bb44@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: luoliang@kylinos.cn
Cc: David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Docs/admin-guide/cgroup-v2: document BPF scheduler
 callbacks for cpu.max and cpu.idle
In-Reply-To: <20260820023744.2005150-1-luoliang@kylinos.cn>
References: <20260819031244.178638-2-luoliang@kylinos.cn>
 <20260820023744.2005150-1-luoliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied to sched_ext/for-7.3-fixes.

Thanks.

--
tejun
