Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172DE1A23B1;
	Thu,  4 Jun 2026 08:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780561973; cv=none; b=g9Ur2QP4mAGZqybR1h+Hkdj8dZ4AT/7piyNRMoUnC6yzlivJ9aJPR73jOHRm1NVSSfRfehlUiu3f4pybEVJj2IIy1zXDI5ev3/4Bs+uDeMIhv3f4tBLRsMDEBopbHpjQcz3VIPY9MKtwt2tmTgEqmwdsKKFDeCZ2EzhHvrFBDmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780561973; c=relaxed/simple;
	bh=EeVjEW5KvKnhd0eWTr+Iacvsk7YDqXxcT8p5aKL/3GI=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=OnNsWsO9SQ+54wIfTjSjtEZmY5xbf5noa1/sVWOJNSbYK8SwDeb8RnO3nssLjKNlA0R0ffiuqQxP6dpxusRsWsSxzX0bX2odAIbkJ+XWqUBApp0EmmUdr8Y5lz1czZfeFTPK2VV3tt1krG+TNxoo9MjucHPg92FuD4iK6rqz7aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VlW7ARRe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VlW7ARRe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C3FE1F00893;
	Thu,  4 Jun 2026 08:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780561972;
	bh=EeVjEW5KvKnhd0eWTr+Iacvsk7YDqXxcT8p5aKL/3GI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=VlW7ARRe28jiX6/vyHkEku629CVnKfwzwzsTaLcq3SndjaCyS+dL64TWhoZQSPjTC
	 qdS97sK3HaFRTDzaFikCIO+DmZnxw8YrGsVrXD4EnI1DeULhL1oT3NZ7GLSjR5WGXJ
	 C6Ao6mzyLfffjkMu0ImXnkt7zgtDYeYY+s4GfurcA3OZlyWealdEzOuGsOaH6XoNQP
	 VtjR+818OGSpinzO2aqJYlnyZ9BQ5SDY1hTIA+aOwj1Xg4f4jnacK7oVkaLZk3rsdm
	 cpVXqrWVXQ13Ja42N50erQB34BcymXXGIQNshnbown6kdrVdRDIB+u+UwfMBBO0lVH
	 k5GZF3DtCIlYg==
Date: Wed, 03 Jun 2026 22:32:50 -1000
Message-ID: <01b2c244ca2f6c1eb4bfd9a254f9a39d@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET v2 sched_ext/for-7.2] sched_ext: cid/cmask
 interface prep
In-Reply-To: <20260604020032.3536466-1-tj@kernel.org>
References: <20260604020032.3536466-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

Applied 1-4 to sched_ext/for-7.2 with Andrea's Reviewed-by added.

Thanks.

--
tejun
