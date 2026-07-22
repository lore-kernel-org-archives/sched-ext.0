Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643534457D2;
	Wed, 22 Jul 2026 18:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784745342; cv=none; b=jnk6TCZUfcJwYao27VIzBveTcI68Oie/BJiiO9XkZeAOawWaEJRZYUbg31DGlDBOUIlWDAHvP3VIMhuqrktXHRAsDK0IvJ0DHhrHfw09F6zUhZBQYvY6gDV12ByV7zSPnuq54mb5RWDo6XjSr+lvuu+YhZYBF+3tSBPomE5y3OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784745342; c=relaxed/simple;
	bh=5SM4Gi7LqPCEHWZCp/CHgZl6mm0/tac6PUrGlHgve7I=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=MQiJPCuFIJuxKdDiVP4N98SUcxPiOUYn1BeMWhVo1R5Gnu7GOTtcY/GMfsPxaIH6LxKX/G8a2YhAyN+yOIHjuuFRXCjyi7xzU7n9EO5VRyRR/0CcADJG/uFTNwGGZufuljklv/QDSOUUpDUH5sHYRRE0rYvbhkophV+XCH7K3Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lKKdp9fz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lKKdp9fz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3D9E1F000E9;
	Wed, 22 Jul 2026 18:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784745339;
	bh=dVBVRW1cdV/B7A+P5lGmbht2RbXa+sMvBXJ+BZXhnzo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=lKKdp9fzWmG6UJW1IsxmwhhdvP1koDbqRzQHXbKqBAfaaadIl66C3vQm5BTlA/yVu
	 iDed7LTcx5pmkXxO8TO1u+dUT+9kgF+47T1D4KCvi1qKydTg1v05H7VrQORWneI8Q0
	 g5BP2q0Lo6TR9xUMi/2DsHWavGV8dwNy0+lMdQMEd8JafSULdHYIFEe8JdmhHhBZYW
	 UhsScDlTL0YeiAp1/MITp+gtoM6JQvVArcEqaKhfvBnl+eygsDxUBzbDlvrVFEWi1V
	 mqQLaWZ1ZByNdSFHKJfWhitNv0BePYNDCGoccOvdnay5NZIhW6s8SFkoOc8GCke3BI
	 YC53mWuj9PsNQ==
Date: Wed, 22 Jul 2026 08:35:38 -1000
Message-ID: <2434032013e3edae6ea0548db08006fc@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Cui Jian <cjian720@163.com>
Cc: Andrea Righi <arighi@nvidia.com>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched_ext: Fix stale errno in scx_sub_enable_workfn()
In-Reply-To: <20260722100352.36627-1-cjian720@163.com>
References: <20260722100352.36627-1-cjian720@163.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

On Wed, Jul 22, 2026 at 06:03:52PM +0800, Cui Jian wrote:
> The nesting depth check and the cgroup online check in
> scx_sub_enable_workfn() reach err_disable without setting ret, so
> the fallback error added by commit db4e9defd2e8 ("sched_ext: Record
> an error on errno-only sub-enable failure") reports
> "scx_sub_enable() failed (0)".

Applied to sched_ext/for-7.3.

Thanks.

-- 
tejun
